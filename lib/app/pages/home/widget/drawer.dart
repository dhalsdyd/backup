import 'package:backup/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _menuItem(String icon, String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profile(),
              const SizedBox(height: 36),
              _menuItem("assets/icons/user.svg", "Account", () {}),
              _menuItem("assets/icons/settings.svg", "Settings", () {}),
              _menuItem("assets/icons/pattern.svg", "Family Code", () {}),
              _menuItem("assets/icons/spectacle.svg", "Manage Family", () {}),
              _menuItem("assets/icons/Insights.svg", "Request Album", () {}),
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
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Column(
          children: const [
            Text("EXAMPLE", style: FGBPTextTheme.text1Bold),
            Text("@EXAMPLE", style: FGBPTextTheme.text1),
          ],
        ),
      ],
    );
  }
}
