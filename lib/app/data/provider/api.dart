import 'dart:developer';

import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/models/user.dart';
import 'package:backup/app/data/service/auth/service.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:dio/dio.dart';
import 'package:backup/app/data/provider/api_interface.dart';
import 'package:get/instance_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JWTInterceptor extends Interceptor {
  final Dio _dioInstance;

  // Dependency Injection
  JWTInterceptor(this._dioInstance);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == '/auth/refresh') {
      return handler.next(options);
    }

    AuthService authService = Get.find<AuthService>();
    //print(authService.accessToken);

    if (authService.isAuthenticated) {
      options.headers['Authorization'] = 'Bearer ${authService.accessToken}';
    } else if (authService.isGoogleLoginSuccess) {
      options.headers['Authorization'] =
          'Bearer ${authService.onboardingToken}';
    }

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    //refresh api가 401시 무한 루프 방지

    AuthService authService = Get.find<AuthService>();
    if (err.response?.requestOptions.path == '/auth/refresh') {
      return handler.next(err);
    }

    if (err.response?.statusCode == 401 &&
        authService.accessToken != null &&
        JwtDecoder.isExpired(authService.accessToken!)) {
      try {
        await authService.refreshAcessToken();

        //api 호출을 다시 시도함
        final Response response = await _dioInstance.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        //refresh 실패 시 401을 그대로 반환
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}

class LogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('${response.requestOptions.method}[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        name: 'DIO');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      log('${err.response!.requestOptions.method}[${err.response!.statusCode}] => PATH: ${err.response!.requestOptions.path}',
          name: 'DIO');
    }
    handler.next(err);
  }
}

class FGBPApiProvider implements FGBPApiInterface {
  final Dio dio = Dio();
  final baseUrl = "https://5gjwe7qbq8.apigw.gov-ntruss.com/sample/v1";

  FGBPApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(JWTInterceptor(dio));
    dio.interceptors.add(LogInterceptor());
  }

  @override
  Future<void> onboardingCreateFamily(String name) async {
    String url = "/onboarding/create-family";
    Map body = {"name": name};
    await dio.post(url, data: body);
  }

  @override
  Future<void> onboardingName(String name) async {
    String url = "/onboarding/name";
    Map body = {"name": name};
    await dio.post(url, data: body);
  }

  @override
  Future<Map> refresh(String refreshToken) async {
    String url = "/auth/refresh";
    Map body = {"refreshToken": refreshToken};
    Response response = await dio.post(url, data: body);
    return response.data;
  }

  @override
  Future<Map> loginWithGoogle(String idToken) async {
    String url = "/auth/login";
    Map body = {"idToken": idToken};
    Response response = await dio.post(url, data: body);
    return response.data;
  }

  @override
  Future<Map> onboardingAuth() {
    // TODO: implement onboardingAuth
    throw UnimplementedError();
  }

  @override
  Future<void> createAlbum(String name, String? description, int? categoryId,
      String? eventDate) async {
    String url = "/album";
    Map body = {"name": name, "categoryId": categoryId, "eventDate": eventDate};

    if (description != null && description.isNotEmpty) {
      body["description"] = description;
    }

    //print(body);
    await dio.post(url, data: body);
  }

  @override
  Future<List<Album>> getAlbums() async {
    String url = "/album?sortType=lastViewed";
    Response response = await dio.get(url);
    return (response.data as List).map((e) => Album.fromJson(e)).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    String url = "/category";
    Response response = await dio.get(url);
    return (response.data as List).map((e) => Category.fromJson(e)).toList();
  }

  @override
  Future<String> uploadFile(
      FileSource fileSource, Function(int, int)? onSendProgress) async {
    String url = "/upload";
    // FormData formData = FormData.fromMap({
    //   "file": await MultipartFile.fromFile(fileSource.path,
    //       filename: fileSource.name),
    // });

    FormData formData2 = FormData.fromMap({
      "file":
          MultipartFile.fromBytes(fileSource.bytes, filename: fileSource.name),
    });

    Response response =
        await dio.post(url, data: formData2, onSendProgress: onSendProgress);
    return response.data["key"];
  }

  @override
  Future<void> createStory(int albumId, String? description, String imageKey) {
    String url = "/story";
    Map body = {"albumId": albumId, "image": imageKey};

    if (description != null && description.isNotEmpty) {
      body["description"] = description;
    }

    return dio.post(url, data: body);
  }

  @override
  Future<AlbumDetail> getAlbumDetails(int albumId) async {
    String url = "/album/$albumId";
    Response response = await dio.get(url);
    return AlbumDetail.fromJson(response.data);
  }

  @override
  Future<Map> enterFamily(String familyCode) async {
    String url = "/onboarding/family-code";
    Map body = {"code": familyCode};
    Response response = await dio.post(url, data: body);
    return response.data;
  }

  @override
  Future<String> getFamilyCode() async {
    String url = "/user/family-code";
    Response response = await dio.get(url);
    return response.data["code"];
  }

  @override
  Future<List<Member>> getFamilyMembers() async {
    String url = "/user/family-members";
    Response response = await dio.get(url);
    return (response.data["members"] as List)
        .map((e) => Member.fromJson(e))
        .toList();
  }

  @override
  Future<Profile> getMyProfile() async {
    String url = "/user/me";
    Response response = await dio.get(url);
    return Profile.fromJson(response.data);
  }

  @override
  Future<TodayStory> getTodayStory() async {
    String url = "/story/today";
    Response response = await dio.get(url);
    return TodayStory.fromJson(response.data);
  }
}
