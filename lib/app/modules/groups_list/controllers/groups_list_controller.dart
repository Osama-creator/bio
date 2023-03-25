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
      QuerySnapshot groups =
          await FirebaseFirestore.instance.collection('groups').get();
      groupList.clear();
      for (var groupI in groups.docs) {
        List<Studen> students = [];
        List<Map<String, dynamic>> studentsData =
            List<Map<String, dynamic>>.from(groupI['students'] ?? []);
        for (var studentData in studentsData) {
          Studen student = Studen(
            name: studentData['name'],
            id: studentData['id'],
            absence: studentData['absence'],
          );
          students.add(student);
        }
        Group group = Group(
          name: groupI['name'],
          id: groupI.id,
          price: groupI['price'],
          sessions: groupI['sessions'],
          students: students,
        );
        groupList.add(group);
      }

      QuerySnapshot categories =
          await FirebaseFirestore.instance.collection('groups').get();
      groupList.clear();
      for (var category in categories.docs) {
        groupList.add(Group(
          name: category['name'],
          id: category.id,
          price: category['price'],
          sessions: category['sessions'],
          students: (category['students'] as List<dynamic>)
              .map((studentData) => Studen(
                    name: studentData['name'],
                    id: studentData['id'],
                    absence: studentData['absence'],
                  ))
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
      Get.snackbar('Success', 'Group deleted successfully');
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
// try {
//   QuerySnapshot categories =
//       await FirebaseFirestore.instance.collection('groups').get();
//   groupList.clear();
//   for (var category in categories.docs) {
//     List<Studen> students = [];
//     List<Map<String, dynamic>> studentsData = List<Map<String, dynamic>>.from(category['students'] ?? []);
//     for (var studentData in studentsData) {
//       Studen student = Studen(
//         name: studentData['name'],
//         id: studentData['id'],
//         absence: studentData['absence'],
//       );
//       students.add(student);
//     }
//     Group group = Group(
//       name: category['name'],
//       id: category.id,
//       price: category['price'],
//       sessions: category['sessions'],
//       students: students,
//     );
//     groupList.add(group);
//   }
// } catch (e) {
//   Get.snackbar('Error', e.toString());
//   error = true;
// } finally {
//   isLoading = false;
//   update();
// }