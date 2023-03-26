import 'dart:developer';

import 'package:bio/app/data/models/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/student_model.dart';
import '../../../routes/app_pages.dart';

class GroupsListController extends GetxController {
  bool isLoading = false;
  var groupList = <Group>[];
  bool error = false;

  Future<void> getData() async {
    isLoading = true;
    try {
      QuerySnapshot categories =
          await FirebaseFirestore.instance.collection('groups').get();
      groupList.clear();
      for (var category in categories.docs) {
        groupList.add(Group(
          name: category['name'],
          id: category.id,
          price: category['price'],
          sessions: category['sessions'],
          currentSession: category['current_session'],
          students: (category['students'] as List<dynamic>)
              .map((studentData) => Studen(
                  name: studentData['name'],
                  id: studentData['id'],
                  absence: studentData['absence'],
                  price: studentData['price']))
              .toList(),
        ));
      }
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
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .delete();
      groupList.removeWhere((group) => group.id == groupId);
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
    getData();
    super.onInit();
  }
}
