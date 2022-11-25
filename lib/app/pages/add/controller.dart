import 'dart:typed_data';

import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/data/module/album/service.dart';
import 'package:backup/app/data/module/category/service.dart';
import 'package:backup/app/pages/add/view/album.dart';
import 'package:backup/app/pages/add/view/thumbnail.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:backup/app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPageController extends GetxController with StateMixin {
  final FileSource fileSource = Get.arguments;

  final CategoryController categoryController = Get.find<CategoryController>();
  final AlbumController albumController = Get.find<AlbumController>();

  Rx<List<Category>> categories = Rx<List<Category>>([]);
  Rx<List<Album>> albums = Rx([]);
  Rx<List<Album>> capsules = Rx([]);

  Rx<int?> selectedCategory = Rx(null);
  Rx<Album?> selectedAlbum = Rx(null);

  Rx<FilePickerResult?> selectedThumbnail = Rx(null);

  void pickFile() async {
    selectedThumbnail.value =
        await FilePicker.platform.pickFiles(withData: true);
    if (selectedThumbnail.value != null) {}
  }

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    nameController.addListener(() {
      albumName.value = nameController.text;
    });
    categories.value = categoryController.categories;
    albums.value = albumController.albums;
    capsules.value = albumController.capsules;
    selectedCategory.value = categories.value.first.id;

    DateTime result = DateTime.now();
    date.value = result.toIso8601String();
    dateController.text = date.value!;
    super.onInit();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final Rx<String?> imageName = Rx(null);
  final Rx<String?> albumName = Rx(null);
  bool get imageValidity =>
      imageName.value != null && imageName.value!.isNotEmpty;
  bool get albumValidity {
    if (albumName.value != null &&
        albumName.value!.isNotEmpty &&
        selectedCategory.value != null &&
        date.value != null &&
        date.value!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  final Rx<String?> date = Rx(null);

  void enterImageName() {
    imageName.value = nameController.text;
    nameController.clear();
    Get.to(() => AlbumPage());
  }

  void autoGenerateAlbum() async {
    change(null, status: RxStatus.loading());

    final Uint8List? thumbnailData = await Get.to(() => SelectThumbnailPage());
    String thumbnailId = "";

    if (thumbnailData == null) {
      thumbnailId = await albumController.uploadFile(
          fileSource, "thumbnailData", (p0, p1) => null);
    } else {
      FileSource thumbnailFileSource = FileSource(
          name: "thumbnailData",
          bytes: thumbnailData,
          path: "thumbnailData",
          isImage: true);

      thumbnailId = await albumController.uploadFile(
          thumbnailFileSource, "thumbnailData", (p0, p1) => null);
    }

    final DateTime now = DateTime.now();
    String albumName = "${DateFormat.MMM().format(now)}. ${now.day}";
    String description = "Auto Generated Album";
    String date = now.toIso8601String();

    try {
      await albumController.createAlbum(albumName, description, date,
          selectedCategory.value, null, thumbnailId);
      selectedThumbnail.value = null;
      Get.back();
    } on DioError catch (e) {
      FGBPSnackBar.open(e.message);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  void makeAlbum() async {
    change(null, status: RxStatus.loading());

    final Uint8List? thumbnailData = await Get.to(() => SelectThumbnailPage());
    String? thumbnailId = null;

    if (thumbnailData == null) {
      thumbnailId = await albumController.uploadFile(
          fileSource, "thumbnailData", (p0, p1) => null);
    } else {
      FileSource thumbnailFileSource = FileSource(
          name: "thumbnailData",
          bytes: thumbnailData,
          path: "thumbnailData",
          isImage: true);

      thumbnailId = await albumController.uploadFile(
          thumbnailFileSource, "thumbnailData", (p0, p1) => null);
    }

    try {
      await albumController.createAlbum(
          albumName.value!,
          descriptionController.text,
          date.value,
          selectedCategory.value,
          null,
          thumbnailId);
      albums.value = albumController.albums;
      capsules.value = albumController.capsules;

      nameController.clear();
      descriptionController.clear();
      dateController.clear();

      albumName.value = null;
      date.value = null;

      selectedThumbnail.value = null;

      Get.back();
    } on DioError catch (e) {
      FGBPSnackBar.open(e.message);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  void selectDate() async {
    DateTime now = DateTime.now();

    DateTime? result = await showDatePicker(
        context: Get.overlayContext!,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDate: now,
        currentDate: now,
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 10, 12, 31));

    if (result != null) {
      date.value = result.toIso8601String();
      dateController.text = date.value!;
    }
  }

  void selectAlbum(int index) {
    if (selectedAlbum.value != null &&
        selectedAlbum.value!.id == albums.value[index].id) {
      selectedAlbum.value = null;
    } else {
      selectedAlbum.value = albums.value[index];
    }
  }

  void selectCapsule(int index) {
    if (selectedAlbum.value != null &&
        selectedAlbum.value!.id == capsules.value[index].id) {
      selectedAlbum.value = null;
    } else {
      selectedAlbum.value = capsules.value[index];
    }
  }

  bool checkSelected(int index) {
    if (selectedAlbum.value != null &&
        selectedAlbum.value!.id == albums.value[index].id) {
      return true;
    } else {
      return false;
    }
  }

  bool checkCapsuleSelected(int index) {
    if (selectedAlbum.value != null &&
        selectedAlbum.value!.id == capsules.value[index].id) {
      return true;
    } else {
      return false;
    }
  }

  final Rx<int> _uploadImageCount = Rx(0);
  final Rx<int> _uploadImageTotal = Rx(0);
  Rx<bool> isUploading = false.obs;

  String get progress {
    if (_uploadImageCount.value == 0 || _uploadImageTotal.value == 0) {
      return "0.0";
    }
    return ((_uploadImageCount.value / _uploadImageTotal.value) * 100)
        .toStringAsFixed(1);
  }

  onSendProgress(int sent, int total) {
    _uploadImageCount.value = sent;
    _uploadImageTotal.value = total;
  }

  void upload() async {
    change(null, status: RxStatus.loading());

    try {
      isUploading.value = true;

      String key = await albumController.uploadFile(
          fileSource, imageName.value, onSendProgress);
      await albumController.addImageToAlbum(
          selectedAlbum.value!.id, imageName.value ?? "", key);
      Get.until((route) => Get.currentRoute == '/home');
    } on DioError catch (e) {
      FGBPSnackBar.open(e.message);
      isUploading.value = true;
      change(null, status: RxStatus.success());
    } finally {
      isUploading.value = true;
      change(null, status: RxStatus.success());
    }
  }
}
