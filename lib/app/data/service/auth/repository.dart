import 'package:backup/app/data/provider/api_interface.dart';

class AuthRepository {
  final FGBPApiInterface api;

  AuthRepository(this.api);

  Future<Map> loginWithGoogle(String idToken) async {
    return {};
  }

  Future<Map> refresh(String refreshToken) async {
    return {};
  }

  Future<Map> onboardingAuth() async {
    return {};
  }
}
