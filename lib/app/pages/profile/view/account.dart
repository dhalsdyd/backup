import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: FGBPTextTheme.text4Bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 16),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(44.0),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: FGBPColors.Brown4, width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(profile.picture),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                profile.name,
                style: FGBPTextTheme.text2Bold,
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
              const SizedBox(height: 16),
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
