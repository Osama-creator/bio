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
    await prefs.remove('userData');
    await prefs.remove('userToken');
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.SIGN_IN);
  }

  bool isConfirmed = false;
  bool isLoading = false;
  var examList = <Exam>[];
  bool error = false;

  Future<void> getData() async {
    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('userData');

      if (userData == null) {
        throw Exception("User data not found in SharedPreferences");
      }

      final userDataMap = jsonDecode(userData);
      final userEmail = userDataMap['email'];

      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userSnapshot.size == 0) {
        throw Exception("User data not found in Firestore");
      }

      final userDoc = userSnapshot.docs.first;
      await prefs.setString('userData', jsonEncode(userDoc.data()));

      isConfirmed = userDoc['confirmed'];
      log(isConfirmed.toString());

      final examsSnapshot = await FirebaseFirestore.instance
          .collection('grades')
          .doc(userDoc['grade_id'])
          .collection('exams')
          .get();

      examList.clear();

      for (var examDoc in examsSnapshot.docs) {
        final questionDataList = examDoc['questions'];
        final questionList = questionDataList.map<Question>((questionData) {
          final wrongAnswers = List<String>.from(questionData['wrong_answer']);
          return Question(
            question: questionData['question'],
            id: questionData['id'],
            rightAnswer: questionData['right_answer'],
            image: questionData['image'],
            wrongAnswers: [
              ...wrongAnswers,
              questionData['right_answer'],
            ]..shuffle(),
          );
        }).toList();

        examList.add(Exam(
          name: examDoc['name'],
          id: examDoc.id,
          date: (examDoc['date'] as Timestamp).toDate(),
          questions: questionList,
        ));
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

  void navigateExamPage(int index) {
    Get.toNamed(
      Routes.STUDENT_EXAM,
      arguments: examList[index],
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
