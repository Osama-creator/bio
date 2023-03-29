import 'dart:developer';

import 'package:bio/app/data/models/group_model.dart';
import 'package:get/get.dart';

class ExamsPageController extends GetxController {
  bool isLoading = false;
  var groupList = <Group>[];
  bool error = false;

  Future<void> getData() async {
    isLoading = true;
    try {} catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
      error = true;
    } finally {
      isLoading = false;
      update();
    }
  }

  void navigate(int index) {}

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
