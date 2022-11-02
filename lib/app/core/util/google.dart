import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignHelper {
  static final GoogleSignHelper _instance = GoogleSignHelper._internal();
  factory GoogleSignHelper() => _instance;
  GoogleSignHelper._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<String> getIdToken() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    return googleAuth.idToken!;
  }
}
