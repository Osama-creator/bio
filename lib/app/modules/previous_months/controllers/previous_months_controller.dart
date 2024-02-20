import 'dart:developer';

import 'package:bio/app/services/lessons_groups.dart';
import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import '../../../data/models/months_model.dart';
import '../../../routes/app_pages.dart';

class PreviousMonthsController extends GetxController {
  final args = Get.arguments as Group;
  bool isLoading = false;
  var groupList = <GroupPreviousMonths>[];
  final lessonAndGroups = LessonsAndGroups();
  Future<void> getData() async {
    isLoading = true;
    try {
      groupList = await lessonAndGroups.getPrevMonthGroups(args.id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteGroupMonth(String monthId) async {
    try {
      groupList = await lessonAndGroups.deleteGroupMonthService(args.id, monthId);
      update();
      Get.snackbar('Success', 'تم حذف الشهر بنجاح');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void navigate(int index) {
    Get.offAndToNamed(
      Routes.PREVIOUS_MONTHS_DETAILS,
      arguments: groupList[index],
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
