abstract class FGBPApiInterface {
  Future<Map> loginWithGoogle(String idToken);
  Future<Map> onboardingAuth();
  Future<Map> refresh(String refreshToken);
  Future<Map> onboardingName(String name);
  Future<Map> onboardingCreateFamily(String name);
}
