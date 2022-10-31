import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin, StateMixin {
  static HomePageController get to =>
      Get.find<HomePageController>(); // add this line

  final scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() => scaffoldKey.currentState!.openDrawer();

  final List<String> myTabs = <String>[
    "Daily",
    "Weekly",
    "Christmas",
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
