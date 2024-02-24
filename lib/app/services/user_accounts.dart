import 'dart:developer';

import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserAccounts {
  Future<List<Student>> getAccounts(String gradeId) async {
    List<Student> studentList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isNotEqualTo: 'admin.mo@gmail.com')
        .where('grade_id', isEqualTo: gradeId)
        .get();
    studentList.clear();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Student student = Student.fromJson(data);
      studentList.add(student);
    }
    return studentList;
  }

  Future<void> manageUserAccount(Student student, bool myBool) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: student.email).get();
    if (querySnapshot.size == 1) {
      String documentId = querySnapshot.docs[0].id;
      await FirebaseFirestore.instance.collection('users').doc(documentId).update({'confirmed': true});
      student.isConfirmed = myBool;
    } else {
      Get.snackbar('Error', 'Student not found');
    }
  }

  Future<List<Student>> deleteStudent(Student student) async {
    List<Student> studentList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: student.email).get();
    if (querySnapshot.size == 1) {
      String documentId = querySnapshot.docs[0].id;
      await FirebaseFirestore.instance.collection('users').doc(documentId).delete();
      studentList.remove(student);

      Get.snackbar('تم', "الحساب اتشيبع", backgroundColor: AppColors.primary);
    } else {
      Get.snackbar('Error', 'Student not found');
    }
    return studentList;
  }

  Future<void> resetPointsToZero(String pointsName) async {
    // Fetch all users
    QuerySnapshot users = await FirebaseFirestore.instance.collection('users').get();

    for (var user in users.docs) {
      // Fetch user data for each user
      DocumentSnapshot<Map<String, dynamic>> userDataQuery =
          await FirebaseFirestore.instance.collection('users').doc(user.id).get();
      var userData = userDataQuery.data();
      if (userData != null) {
        // Update the student marks field in the user document
        await FirebaseFirestore.instance.collection('users').doc(user.id).update({
          pointsName: 0,
        });
      }
    }
  }

  Future<void> resetUsersMark() async {
    // Fetch all users
    QuerySnapshot users = await FirebaseFirestore.instance.collection('users').get();

    for (var user in users.docs) {
      // Fetch user data for each user
      DocumentSnapshot<Map<String, dynamic>> userDataQuery =
          await FirebaseFirestore.instance.collection('users').doc(user.id).get();
      var userData = userDataQuery.data();
      if (userData != null) {
        QuerySnapshot exams =
            await FirebaseFirestore.instance.collection('grades').doc(userData['grade_id']).collection('exams').get();
        num sumOfMarks = 0;
        for (var exam in exams.docs) {
          // Loop through all exam marks for the current exam and user
          QuerySnapshot marks = await FirebaseFirestore.instance
              .collection('grades')
              .doc(userData['grade_id'])
              .collection('exams')
              .doc(exam.id)
              .collection('markes')
              .where('email', isEqualTo: userData['email'])
              .get();

          for (var mark in marks.docs) {
            // Retrieve and add the student_mark to the sum
            sumOfMarks += mark['student_mark'] as num;
          }
        }
        // Update the student marks field in the user document
        await FirebaseFirestore.instance.collection('users').doc(user.id).update({'marks': sumOfMarks});
        log("Updated sumOfMarks: $sumOfMarks");
      }
    }
  }
}
