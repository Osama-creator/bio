import 'dart:developer';

import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentsAccountsController extends GetxController {
  bool isLoading = false;
  List<Student> studentList = [];
  int updatedUsersCount = 0;
  bool upadataingUsers = false;
  Future<void> getData() async {
    isLoading = true;
    update();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isNotEqualTo: 'admin.mo@gmail.com')
          .get();
      studentList.clear();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Student student = Student.fromJson(data);
        studentList.add(student);
      }
    } catch (e, st) {
      Get.snackbar('Error', e.toString());
      log(st.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  String searchQuery = '';

  void setSearchQuery(String query) {
    searchQuery = query;
    update();
  }

  Future<void> addNewFieldsToAllUsers() async {
    try {
      // Query for all user documents
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String documentId = doc.id;
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;

        // Check if the fields exist, and add them if not
        if (!userData.containsKey('right_answers')) {
          userData['right_answers'] = 0;
        }
        if (!userData.containsKey('wrong_answers')) {
          userData['wrong_answers'] = 0;
        }
        if (!userData.containsKey('exam_count')) {
          userData['exam_count'] = 0;
        }
        if (!userData.containsKey('nickname')) {
          userData['nickname'] = "";
        }

        // Update the document with the new fields
        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .update(userData);
      }

      update(); // Update the UI to reflect changes
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  List<Student> get filteredStudents {
    return studentList.where((student) {
      final lowerQuery = searchQuery.toLowerCase();
      final studentName = student.name.toLowerCase();
      return studentName.contains(lowerQuery);
    }).toList();
  }

  Future<void> confirmUser(Student student) async {
    try {
      isLoading = true;
      update();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: student.email)
          .get();

      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .update({'confirmed': true});

        student.isConfirmed = true;
        update();
      } else {
        Get.snackbar('Error', 'Student not found');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteUser(Student student) async {
    try {
      isLoading = true;
      update();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: student.email)
          .get();

      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .delete();
        studentList.remove(student);
        Get.snackbar('تم', "الحساب اتشيبع", backgroundColor: AppColors.primary);
        update();
      } else {
        Get.snackbar('Error', 'Student not found');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> resetWPointsToZero() async {
    try {
      isLoading = true;
      upadataingUsers = true;
      update();
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String documentId = doc.id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .update({'w_points': 0});
        updatedUsersCount++;
        update();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      upadataingUsers = false;
      update();
    }
  }

  Future<void> deconfirmUser(Student student) async {
    try {
      isLoading = true;
      update();
      // Query for the document based on student data
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: student.email)
          .get();

      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .update({'confirmed': false});

        student.isConfirmed = false;
        update();
      } else {
        Get.snackbar('Error', 'Student not found');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
