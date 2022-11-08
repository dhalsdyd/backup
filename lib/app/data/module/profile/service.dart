import 'dart:async';

import 'package:backup/app/data/models/user.dart';
import 'package:backup/app/data/module/profile/repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with StateMixin {
  final ProfileRepository repository;

  ProfileController(this.repository);

  Timer? refreshTimer;
  Timer? showTimer;
  Rx<int?> leftTime = Rx(null);
  Rx<String?> familyCode = Rx(null);

  Future<void> getFamilyCode() async {
    change(null, status: RxStatus.loading());
    try {
      familyCode.value = await repository.getFamilyCode();
      refreshFamilyCode();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future refreshFamilyCode() async {
    refreshTimer?.cancel();
    showTimer?.cancel();
    leftTime.value = 60;
    refreshTimer = Timer(const Duration(seconds: 60), () => getFamilyCode());
    showTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      leftTime.value = leftTime.value! - 1;
      if (leftTime.value! < 0) {
        leftTime.value = 0;
      }
    });
  }

  void disposeCode() {
    refreshTimer?.cancel();
    showTimer?.cancel();
    leftTime.value = null;
    familyCode.value = null;
  }

  Rx<Profile?> profile = Rx(null);
  Rx<List<Member>?> members = Rx(null);

  getProfile() async {
    profile.value = await repository.getMyProfile();
  }

  getMembers() async {
    members.value = await repository.getFamilyMembers();
  }

  Future<void> init() async {
    change(null, status: RxStatus.loading());
    try {
      await getProfile();
      await getMembers();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onInit() async {
    await init();
    super.onInit();
  }
}
