import 'dart:developer';

import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:bio/app/data/models/group_model.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ExamsPageController extends GetxController {
  final args = Get.arguments as GradeItem;
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

  void navigate() {
    Get.toNamed(
      Routes.CREATE_EXAM,
      arguments: args,
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
