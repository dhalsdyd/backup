import 'dart:typed_data';

import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/data/module/album/service.dart';
import 'package:backup/app/data/module/category/service.dart';
import 'package:backup/app/data/module/profile/service.dart';
import 'package:backup/app/data/service/auth/service.dart';
import 'package:backup/app/pages/detail/page.dart';
import 'package:backup/app/pages/home/widget/camera.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin, StateMixin {
  final AuthService authService = Get.find<AuthService>();
  final CategoryController categoryController = Get.find<CategoryController>();
  final AlbumController albumController = Get.find<AlbumController>();
  final ProfileController profileController = Get.find<ProfileController>();

  static HomePageController get to =>
      Get.find<HomePageController>(); // add this line

  Rx<FilePickerResult?> filePickerResult = Rx(null);
  Rx<CameraController?> cameraController = Rx(null);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() => scaffoldKey.currentState!.openDrawer();

  Rx<List<Category>> myTabs = Rx([]);
  List<Album> get albums => albumController.albums;

  late TabController tabController;

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    final camera = await availableCameras();
    cameraController.value =
        CameraController(camera[0], ResolutionPreset.medium);

    myTabs.value = (await categoryController.getCategories());
    tabController = TabController(vsync: this, length: myTabs.value.length);
    change(null, status: RxStatus.success());
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void pickFile() async {
    filePickerResult.value =
        await FilePicker.platform.pickFiles(withData: true);
    if (filePickerResult.value != null) {
      addPage(filePickerResult.value);
    }
  }

  void logout() async {
    await authService.logout();
    Get.offAllNamed('/login');
  }

  void openCamera() async {
    await cameraController.value!.initialize();
    XFile photoResult =
        await Get.to(() => CameraPage(controller: cameraController.value!));
    addPage(photoResult);
  }

  void openVideo() async {
    await cameraController.value!.initialize();
    XFile videoResult = await Get.to(
        CameraPage(controller: cameraController.value!, isPhoto: false));
    addPage(videoResult);
  }

  void addPage(dynamic data) async {
    if (data is FilePickerResult) {
      FileSource fileSource = FileSource(
        name: data.files.first.name,
        path: GetPlatform.isWeb ? "" : data.files.first.path ?? "",
        bytes: data.files.first.bytes!,
        isImage: data.files.first.extension != "mp4",
      );

      Get.toNamed("/add", arguments: fileSource);
    } else if (data is XFile) {
      Uint8List bytes = await data.readAsBytes();

      FileSource fileSource = FileSource(
        name: data.name,
        path: data.path,
        bytes: bytes,
        isImage: data.path.split(".").last != "mp4",
      );
      Get.toNamed("/add", arguments: fileSource);
    }
  }

  void detailPage(int albumId, String thumbnail) async {
    AlbumDetail albumDetail = await albumController.getAlbumDetail(albumId);
    Get.to(() => AlbumDetailPage(),
        arguments: {"detail": albumDetail, "thumbnail": thumbnail});
  }

  List<Album> getAlbumsByCategory(int categoryId) {
    return albums.where((element) => element.categoryId == categoryId).toList();
  }
}

class FileSource {
  String name;
  String path;
  Uint8List bytes;
  bool isImage;

  FileSource({
    required this.name,
    required this.path,
    required this.bytes,
    required this.isImage,
  });
}
