import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/user.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Account",
          style: FGBPTextTheme.text4Bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(44.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profile.picture),
                radius: 50,
              ),
              const SizedBox(height: 16),
              Text(
                profile.name,
                style: FGBPTextTheme.text2Bold,
              ),
              Text(
                "@EXAMPLE",
                style: FGBPTextTheme.text1.copyWith(color: FGBPColors.Black3),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Family Name",
                    style: FGBPTextTheme.text2Bold,
                  ),
                  Text(
                    profile.family.name,
                    style:
                        FGBPTextTheme.text2.copyWith(color: FGBPColors.Black2),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Members",
                    style: FGBPTextTheme.text2Bold,
                  ),
                  Text(
                    profile.family.memberCount.toString(),
                    style:
                        FGBPTextTheme.text2.copyWith(color: FGBPColors.Black2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
