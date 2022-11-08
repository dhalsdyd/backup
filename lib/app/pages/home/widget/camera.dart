import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key, required this.controller, this.isPhoto = true})
      : super(key: key);

  final CameraController controller;
  final bool isPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            CameraPreview(controller),
            // photo button
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: _cameraButton(isPhoto: isPhoto),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cameraButton({bool isPhoto = true}) {
    if (isPhoto) {
      return GestureDetector(
        onTap: () async {
          try {
            final image = await controller.takePicture();
            Get.back(result: image);
          } catch (_) {
            //print(e);
          }
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          try {
            await controller.startVideoRecording();

            //1.5초 후에 자동으로 녹화 종료
            Timer(const Duration(seconds: 10), () async {
              final video = await controller.stopVideoRecording();
              Get.back(result: video);
            });
          } catch (_) {
            
          }
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
    }
  }
}
