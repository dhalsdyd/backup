import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/data/module/album/service.dart';
import 'package:backup/app/data/module/category/service.dart';
import 'package:backup/app/pages/add/album.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:backup/app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPageController extends GetxController with StateMixin {
  final FileSource fileSource = Get.arguments;

  final CategoryController categoryController = Get.find<CategoryController>();
  final AlbumController albumController = Get.find<AlbumController>();

  Rx<List<Category>> categories = Rx<List<Category>>([]);
  Rx<List<Album>> albums = Rx([]);

  Rx<int?> selectedCategory = Rx(null);
  Rx<Album?> selectedAlbum = Rx(null);

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    nameController.addListener(() {
      albumName.value = nameController.text;
    });
    categories.value = categoryController.categories;
    albums.value = albumController.albums;
    selectedCategory.value = categories.value.first.id;
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

  void makeAlbum() async {
    change(null, status: RxStatus.loading());

    try {
      await albumController.createAlbum(albumName.value!,
          descriptionController.text, date.value, selectedCategory.value);
      albums.value = albumController.albums;

      nameController.clear();
      descriptionController.clear();
      dateController.clear();

      albumName.value = null;
      date.value = null;

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
        lastDate: DateTime(DateTime.now().year, 12, 31));
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

  bool checkSelected(int index) {
    if (selectedAlbum.value != null &&
        selectedAlbum.value!.id == albums.value[index].id) {
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