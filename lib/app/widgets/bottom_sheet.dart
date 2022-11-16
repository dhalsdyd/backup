import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum FGBPActionType { picture, video, file, capsule }

extension FGBPActionTypeExtension on FGBPActionType {
  String get title {
    switch (this) {
      case FGBPActionType.picture:
        return "Take Picture";
      case FGBPActionType.video:
        return "Take Video";
      case FGBPActionType.file:
        return "Browse File";
      case FGBPActionType.capsule:
        return "Create Capsule";
    }
  }

  String get icon {
    switch (this) {
      case FGBPActionType.picture:
        return "assets/icons/camera.png";
      case FGBPActionType.video:
        return "assets/icons/media.svg";
      case FGBPActionType.file:
        return "assets/icons/folder.png";
      case FGBPActionType.capsule:
        return "assets/icons/capsule.svg";
    }
  }

  Color get color {
    switch (this) {
      case FGBPActionType.picture:
        return FGBPColors.Black1;
      case FGBPActionType.video:
        return FGBPColors.Black1;
      case FGBPActionType.file:
        return FGBPColors.Black1;
      case FGBPActionType.capsule:
        return FGBPColors.Black1;
    }
  }
}

class FGBPBottomSheet {
  List<FGBPActionType> _buttonTypeList = [];
  FGBPBottomSheet(List<FGBPActionType> buttonTypeList) {
    _buttonTypeList = buttonTypeList;
  }

  Future show() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: Get.overlayContext!,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _buttonTypeList
                    .map((e) => FGBPAcitionButton(actionType: e))
                    .toList(),
              ),
            ),
          );
        });
  }
}

class FGBPAcitionButton extends StatelessWidget {
  final FGBPActionType actionType;

  const FGBPAcitionButton({Key? key, required this.actionType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSvg = actionType.icon.contains(".svg");

    return GestureDetector(
      onTap: () => Get.back(result: actionType),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: isSvg
                      ? SvgPicture.asset(actionType.icon)
                      : Image.asset(actionType.icon),
                ),
                const SizedBox(width: 16),
                Text(
                  actionType.title,
                  style:
                      FGBPTextTheme.text2Bold.copyWith(color: actionType.color),
                )
              ],
            ),
          ),
          Divider(
            color: FGBPColors.Black1.withOpacity(0.2),
            thickness: 1,
          )
        ],
      ),
    );
  }
}
