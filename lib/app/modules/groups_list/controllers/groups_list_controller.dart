import 'dart:developer';

import 'package:bio/app/data/models/group_model.dart';
import 'package:bio/app/services/utils_service.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class GroupsListController extends GetxController {
  bool isLoading = false;
  var groupList = <Group>[];
  bool error = false;
  final utilsService = UtilsService();
  Future<void> getGroupsData() async {
    isLoading = true;
    try {
      groupList = await utilsService.getGroupsFromAPI();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
      error = true;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteGroup(String groupId) async {
    try {
      groupList = await utilsService.deleteGroup(groupId);
      update();
      Get.snackbar('Success', 'تم حذف المجموعه بنجاح');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void navigate(int index) {
    Get.toNamed(
      Routes.SHOW_GRUOP_DETAILS,
      arguments: groupList[index],
    );
  }

  @override
  void onInit() {
    getGroupsData();
    super.onInit();
  }
}
