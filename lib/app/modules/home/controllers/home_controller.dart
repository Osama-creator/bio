import 'dart:convert';
import 'dart:developer';

import 'package:bio/app/data/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/exam_model.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
    await prefs.remove('userData');
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.SIGN_IN);
  }

  bool isLoading = false;
  var examList = <Exam>[];
  bool error = false;

  Future<void> getData() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    final data = jsonDecode(userData!);
    try {
      QuerySnapshot exams = await FirebaseFirestore.instance
          .collection('grades')
          .doc(data['grade'])
          .collection('exams')
          .get();
      examList.clear();
      for (var exam in exams.docs) {
        List<dynamic> questionDataList = exam['questions'];
        List<Question> questionList = [];

        for (var questionData in questionDataList) {
          List<dynamic> wrongAnswers = questionData['wrong_answer'];
          questionList.add(Question(
              question: questionData['question'],
              id: questionData['id'],
              rightAnswer: questionData['right_answer'],
              image: questionData['image'],
              wrongAnswers: [
                wrongAnswers[0],
                wrongAnswers[1],
                wrongAnswers[2],
                questionData['right_answer'],
              ]..shuffle()));
        }

        examList.add(Exam(
          name: exam['name'],
          id: exam.id,
          questions: questionList,
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

  void navigateExamPage(int index) {
    Get.toNamed(
      Routes.STUDENT_EXAM,
      arguments: examList[index].questions,
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
