import 'dart:convert';
import 'dart:developer';

import 'package:bio/app/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentsLeagueController extends GetxController {
  bool isLoading = false;
  List<Student> studentList = [];
  Future<void> getData() async {
    isLoading = true;
    update();
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData == null) {
      throw Exception("User data not found in SharedPreferences");
    }
    final userDataMap = jsonDecode(userData);
    final userEmail = userDataMap['grade_id'];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('grade_id', isEqualTo: userEmail)
          .get();
      studentList.clear();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Student student = Student.fromJson(data);
        studentList.add(student);
        studentList.sort((a, b) => b.marks!.compareTo(a.marks!));
      }
    } catch (e, st) {
      Get.snackbar('Error', e.toString());
      log(st.toString());
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
