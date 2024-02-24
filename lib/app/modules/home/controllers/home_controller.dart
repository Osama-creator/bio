import 'dart:developer';
import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/services/exam/exam.dart';
import 'package:bio/app/services/user_local.dart';
import 'package:bio/app/services/user_marks_league.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/exam_model.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  bool isConfirmed = false;
  bool isLoading = false;
  var examList = <Exam>[];
  bool error = false;
  final examService = ExamService();
  final userLocalData = UserDataService();
  Student? student;
  Future<void> signOut() async {
    await userLocalData.clearUserDataLocal();
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.SIGN_IN);
  }

  final marksService = MarksAndLeague();
  Future<void> getMarks() async {
    try {
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: student!.email).get();
      final documentId = userSnapshot.docs[0].id;
      var studentData = await userLocalData.getUserDataFromLocal();
      await marksService.updateMark(studentData, documentId);
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getExamsData() async {
    try {
      isLoading = true;
      update();
      student = await userLocalData.getUserFromLocal();
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: student!.email).get();
      if (userSnapshot.size == 0) {
        throw Exception("User data not found in Firestore");
      }
      final userDoc = userSnapshot.docs.first;
      await userLocalData.saveUserDataToPrefs(userDoc.data());
      isConfirmed = userDoc['confirmed'];
      log(isConfirmed.toString());
      examList = await examService.getExams(student!.gradeId, false);
      for (var element in examList) {
        isExamInfoAvailable(element.id);
      }
      examList.sort((a, b) => a.date.compareTo(b.date));
      error = false;
    } catch (e) {
      error = true;
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> isExamInfoAvailable(String examId) async {
    final prefs = await SharedPreferences.getInstance();
    final examInfo = prefs.getString('exam_$examId');
    return examInfo != null;
  }

  void navigateExamPage(int index) {
    Get.toNamed(
      Routes.STUDENT_EXAM,
      arguments: examList[index],
    );
  }

  @override
  void onInit() {
    getExamsData();
    super.onInit();
  }
}
