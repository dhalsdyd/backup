import 'dart:developer';

import 'package:backup/app/data/service/auth/service.dart';
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
    AuthService authService = Get.find<AuthService>();
    //refresh api가 401시 무한 루프 방지
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
  final baseUrl = "https:...";

  FGBPApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(JWTInterceptor(dio));
    dio.interceptors.add(LogInterceptor());
  }

  @override
  Future<Map> onboardingCreateFamily(String name) {
    // TODO: implement onboardingCreateFamily
    throw UnimplementedError();
  }

  @override
  Future<Map> onboardingName(String name) {
    // TODO: implement onboardingName
    throw UnimplementedError();
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
}
