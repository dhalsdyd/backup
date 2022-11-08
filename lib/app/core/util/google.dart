import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignHelper {
  static final GoogleSignHelper _instance = GoogleSignHelper._internal();
  factory GoogleSignHelper() => _instance;
  GoogleSignHelper._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> getIdToken({bool selectAccount = true}) async {
    if (selectAccount && _googleSignIn.currentUser != null) {
      try {
        if (Platform.isAndroid) {
          await _googleSignIn.signOut();
        } else {
          await _googleSignIn.disconnect();
        }
      } catch (e) {
        await _googleSignIn.disconnect();
      }
    }
    final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) {
      throw Exception('google 로그인이 취소됨');
    }
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;
    return googleAuth.idToken!;
  }
}
