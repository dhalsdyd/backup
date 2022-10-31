import 'package:backup/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(44),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/login.svg"),
                  const SizedBox(height: 12),
                  const Text("BackUP", style: FGBPTextTheme.logo),
                  const SizedBox(height: 12),
                  const Text("Let’s save your Family memory",
                      style: FGBPTextTheme.text4Bold),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/google.svg"),
                    const Expanded(
                      child: Text("Login With Google",
                          style: FGBPTextTheme.text4Bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
