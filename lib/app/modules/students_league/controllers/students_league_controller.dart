import 'dart:developer';

import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/modules/students_league/controllers/league_managing_controller.dart';
import 'package:bio/app/services/user_marks_league.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentsLeagueController extends GetxController with LeagueManagingController {
  bool isLoading = false;
  final leagueService = MarksAndLeague();
  double studentStudentRF = 0;
  Student? student;
  Future<void> getData() async {
    isLoading = true;
    update();
    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: student!.email).get();
    final documentId = userSnapshot.docs[0].id;
    final userData = await userDataService.getUserDataFromLocal();
    await leagueService.updateMark(userData, documentId);
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').where('grade_id', isEqualTo: student!.gradeId).get();
      studentList.clear();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Student student = Student.fromJson(data);
        studentList.add(student);
      }
      categorizeStudents();
    } catch (e, st) {
      Get.snackbar('Error', e.toString());
      log(st.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() async {
    student = await userDataService.getUserFromLocal();
    studentStudentRF = student!.rightAnswers / student!.wrongAnswers;
    userLeage = determineLeague(student!.marks!);
    update();
    getData();
    super.onInit();
  }
}
