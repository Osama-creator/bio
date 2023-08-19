import 'dart:developer';

import 'package:bio/app/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentsAccountsController extends GetxController {
  bool isLoading = false;
  List<Student> studentList = [];

  Future<void> getData() async {
    isLoading = true;
    update();

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
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

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
