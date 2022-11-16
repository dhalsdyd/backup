import 'package:backup/app/core/theme/color_theme.dart';
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

  Widget familyCode() {
    return controller.familyCode.value == null
        ? const SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controller.familyCode
                .split("")!
                .map((e) => Column(
                      children: [
                        Text(e, style: FGBPTextTheme.head1),
                        const SizedBox(height: 8),
                        Container(
                          width: 30,
                          height: 2,
                          decoration: const BoxDecoration(
                            color: FGBPColors.Black1,
                          ),
                        ),
                      ],
                    ))
                .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
   
        title: const Text(
          "Family Code",
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
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: [
                    familyCode(),
                    const SizedBox(height: 16),
                    Text(
                      "refresh in : ${controller.leftTime.value ?? 0}s",
                      style: FGBPTextTheme.text1,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("What is family code?",
                            style: FGBPTextTheme.head2),
                        const SizedBox(height: 8),
                        Text(
                            "Family code can invite someone to your family group.",
                            style: FGBPTextTheme.text1
                                .copyWith(color: FGBPColors.Black3)),
                        const SizedBox(height: 26),
                        const Text("Is the code permanent ?",
                            style: FGBPTextTheme.head2),
                        const SizedBox(height: 8),
                        Text(
                            "Code is only available in one minute. But you can generate the code whenever you want.",
                            style: FGBPTextTheme.text1
                                .copyWith(color: FGBPColors.Black3)),
                      ],
                    ),
                  ))

              //left Time
            ],
          ),
        ),
      ),
    );
  }
}
