import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/module/profile/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamilyCodePage extends StatefulWidget {
  const FamilyCodePage({Key? key}) : super(key: key);

  @override
  State<FamilyCodePage> createState() => _FamilyCodePageState();
}

class _FamilyCodePageState extends State<FamilyCodePage> {
  @override
  void initState() {
    controller.getFamilyCode();
    super.initState();
  }

  @override
  dispose() {
    controller.disposeCode();
    super.dispose();
  }

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Family Code",
          style: FGBPTextTheme.text4Bold,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      controller.familyCode.value ?? "Loading...",
                      style: FGBPTextTheme.text2Bold,
                    ),
                    Text(
                      "Left Time: ${controller.leftTime.value ?? 0}",
                      style: FGBPTextTheme.text2Bold,
                    ),
                  ],
                ),
              ),
            ),

            //left Time
          ],
        ),
      ),
    );
  }
}
