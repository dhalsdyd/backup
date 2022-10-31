import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/routes/route.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegisterCodePage extends StatelessWidget {
  const RegisterCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Do you have Family Code?",
                      style: FGBPTextTheme.head2,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "It’s okay if you don’t have the code. You can create a new family group",
                      style: FGBPTextTheme.text2,
                    ),
                    const SizedBox(height: 50),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 300, maxWidth: 500),
                      child: PinCodeTextField(
                        autoFocus: true,
                        appContext: context,
                        length: 6,
                        onChanged: (_) {},
                        onCompleted: (_) {},
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 60,
                            fieldWidth: 45,
                            selectedColor: FGBPColors.Black1,
                            activeColor: FGBPColors.Black1,
                            inactiveColor: FGBPColors.Black3),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("or, Make Family Group",
                        style: FGBPTextTheme.text2
                            .copyWith(decoration: TextDecoration.underline)),
                  ],
                ),
              ),
              FGBPMediumTextButton(
                text: "Join the Family",
                onTap: () {
                  Get.toNamed(Routes.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
