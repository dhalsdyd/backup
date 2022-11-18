import 'dart:async';
import 'dart:io';

import 'package:backup/app/core/theme/text_theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          } catch (_) {}
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

class VideoRecorderExample extends StatefulWidget {
  const VideoRecorderExample({Key? key, required this.controller})
      : super(key: key);
  final CameraController controller;

  @override
  _VideoRecorderExampleState createState() {
    return _VideoRecorderExampleState();
  }
}

class _VideoRecorderExampleState extends State<VideoRecorderExample> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: widget.controller.value.isRecordingVideo
                      ? Colors.redAccent
                      : Colors.grey,
                  width: 3.0,
                ),
              ),
              child: Center(
                child: _cameraPreviewWidget(),
              ),
            ),
            Positioned(
              top: 10,
              child: Text(
                recordingTime,
                style: FGBPTextTheme.text2Bold.copyWith(color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 10,
              child: _captureControlRowWidget(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  // Display 'Loading' text when the camera is still loading.
  Widget _cameraPreviewWidget() {
    if (!widget.controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: CameraPreview(widget.controller),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).

  /// Display the control bar with buttons to record videos.
  Widget _captureControlRowWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: widget.controller.value.isRecordingVideo
            ? IconButton(
                icon: const Icon(Icons.stop),
                color: Colors.red,
                onPressed: _onStopButtonPressed,
              )
            : IconButton(
                icon: const Icon(Icons.videocam),
                color: Colors.blue,
                onPressed: _onRecordButtonPressed,
              ),
      ),
    );
  }

  void _onRecordButtonPressed() async {
    try {
      await widget.controller.startVideoRecording();
      isRecording = true;
      setState(() {});
      Fluttertoast.showToast(
          msg: 'Recording video started',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      recordTime();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  void _onStopButtonPressed() async {
    XFile result = await widget.controller.stopVideoRecording();
    isRecording = false;
    if (mounted) setState(() {});
    if (result != null) {
      Fluttertoast.showToast(
          msg: 'Video recorded to',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      Get.back(result: result);
    }
  }

  void _showCameraException(CameraException e) {
    //String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    //print(errorText);

    Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  String recordingTime = '0:0'; // to store value
  bool isRecording = false;

  void recordTime() {
    var startTime = DateTime.now();
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      var diff = DateTime.now().difference(startTime);

      recordingTime =
          '${diff.inHours < 60 ? diff.inHours : 0}:${diff.inMinutes < 60 ? diff.inMinutes : 0}:${diff.inSeconds < 60 ? diff.inSeconds : 0}';

      //print(recordingTime);

      if (!isRecording) {
        t.cancel(); //cancel function calling
      }

      setState(() {});
    });
  }
}
