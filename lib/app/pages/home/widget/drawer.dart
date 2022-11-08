import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/module/profile/service.dart';
import 'package:backup/app/pages/profile/view/account.dart';
import 'package:backup/app/pages/profile/view/family_code.dart';
import 'package:backup/app/pages/profile/view/manage_family.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);

  final ProfileController controller = Get.find<ProfileController>();

  Widget _menuItem(String icon, String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Text(
              ">",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profile(),
              const SizedBox(height: 36),
              _menuItem("assets/icons/user.svg", "Account", () {
                Get.to(() => AccountPage(profile: controller.profile.value!));
              }),
              _menuItem("assets/icons/settings.svg", "Settings", () {}),
              _menuItem("assets/icons/pattern.svg", "Family Code", () {
                Get.to(() => FamilyCodePage());
              }),
              _menuItem("assets/icons/spectacle.svg", "Manage Family", () {
                Get.to(
                    () => ManageFamilyPage(members: controller.members.value!));
              }),
              _menuItem("assets/icons/Insights.svg", "Request Album", () {}),
              Expanded(child: Container()),
              const Text("Smile DeveloperS", style: FGBPTextTheme.description),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image:
                        NetworkImage(controller.profile.value?.picture ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.profile.value?.name ?? "",
                      style: FGBPTextTheme.text1Bold),
                  Text("@EXAMPLE",
                      style: FGBPTextTheme.text1.copyWith(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        FGBPIconButton(
          "assets/icons/cross.svg",
          onTap: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
