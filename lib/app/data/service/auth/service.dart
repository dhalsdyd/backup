import 'dart:async';
import 'dart:developer';

import 'package:backup/app/core/util/google.dart';
import 'package:backup/app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:backup/app/data/service/auth/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final AuthRepository repository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Completer<void>? _refreshTokenApiCompleter;
  final Rx<String?> _accessToken = Rx(null);
  final Rx<String?> _refreshToken = Rx(null);
  final Rx<String?> _onboardingToken =
      Rx(null); // /auth/login API에서 반환되는 AccessToken
  final Rx<bool> _isFirstVisit = Rx(false);

  /// Access Token
  bool get isGoogleLoginSuccess => _onboardingToken.value != null;

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => _accessToken.value != null;

  String? get accessToken => _accessToken.value;
  String? get refreshToken => _refreshToken.value;
  String? get onboardingToken => _onboardingToken.value;
  bool get isFirstVisit => _isFirstVisit.value;

  AuthService(this.repository);

  Future<AuthService> init() async {
    log("message: AuthService init()");
    try {
      _accessToken.value = await _storage.read(key: 'accessToken');
      _refreshToken.value = await _storage.read(key: 'refreshToken');
    } catch (e) {
      log("message: AuthService init() error: $e");
    }

    log("message : _accessToken.value : ${_accessToken.value}");
    return this;
  }

  Future<void> _setAccessToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
    _accessToken.value = token;
  }

  Future<void> _setRefreshToken(String token) async {
    await _storage.write(key: 'refreshToken', value: token);
    _refreshToken.value = token;
  }

  Future<void> loginWithGoogle() async {
    String idToken = await GoogleSignHelper().getIdToken();
    Map loginResult = await repository.loginWithGoogle(idToken);
    _accessToken.value = loginResult["token"]['accessToken'];
    _refreshToken.value = loginResult["token"]['refreshToken'];
    //_onboardingToken.value = loginResult["token"]['accessToken'];
    _isFirstVisit.value = loginResult['onbaording'];
    _setAccessToken(_accessToken.value!);
    _setRefreshToken(_refreshToken.value!);
  }

  Future<void> login() async {
    try {
      Map loginResult = await repository.onboardingAuth();
      _setAccessToken(loginResult["data"]["accessToken"]);
      _setRefreshToken(loginResult["data"]["refreshToken"]);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<void> refreshAcessToken() async {
    if (_refreshTokenApiCompleter != null) {
      return _refreshTokenApiCompleter!.future;
    }
    _refreshTokenApiCompleter = Completer<void>();
    try {
      Map refreshResult = await repository.refresh(_refreshToken.value!);
      _setAccessToken(refreshResult["data"]["accessToken"]);
      _setRefreshToken(refreshResult["data"]["refreshToken"]);
    } on DioError catch (_) {
      rethrow;
    } finally {
      _refreshTokenApiCompleter!.complete();
      _refreshTokenApiCompleter = null;
    }
  }

  Future<void> logout() async {
    _accessToken.value = null;
    _refreshToken.value = null;
    _onboardingToken.value = null;
    _refreshTokenApiCompleter = null;

    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }

  Future<void> createFamily(String name) async {
    try {
      await repository.createFamily(name);
    } on DioError catch (e) {
      FGBPSnackBar.open(e.message);
      print(e.response!.data);
    }
  }

  Future<void> enterFamily(String code) async {
    try {
      await repository.enterFamily(code);
    } on DioError catch (e) {
      FGBPSnackBar.open(e.message);
    }
  }

  Future<void> enterName(String name) async {
    try {
      await repository.enterName(name);
    } on DioError catch (e) {
      FGBPSnackBar.open(e.message);
    }
  }
}
