import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import '../../../data/models/months_model.dart';
import '../../../data/models/student_model.dart';
import '../../../routes/app_pages.dart';

class PreviousMonthsController extends GetxController {
  final args = Get.arguments as Group;
  bool isLoading = false;
  var groupList = <GroupPreviousMonths>[];
  Future<void> getData() async {
    isLoading = true;
    try {
      QuerySnapshot categories = await FirebaseFirestore.instance
          .collection('groups')
          .doc(args.id)
          .collection('group previous months')
          .get();
      groupList.clear();
      for (var category in categories.docs) {
        groupList.add(GroupPreviousMonths(
          groupId: category.id,
          sessions: category['sessions'],
          date: category['date'],
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
    } finally {
      isLoading = false;
      update();
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
