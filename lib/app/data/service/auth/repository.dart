import 'package:backup/app/data/provider/api_interface.dart';

class AuthRepository {
  final FGBPApiInterface api;

  AuthRepository(this.api);

  Future<Map> loginWithGoogle(String idToken) => api.loginWithGoogle(idToken);

  Future<Map> refresh(String refreshToken) async {
    return {};
  }

  Future<Map> onboardingAuth() async {
    return {};
  }

  Future<void> createFamily(String name) => api.onboardingCreateFamily(name);
  Future<void> enterName(String name) => api.onboardingName(name);
}
