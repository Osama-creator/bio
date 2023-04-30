import 'dart:developer';
import 'dart:io';

import 'package:bio/app/data/models/exam_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/question_model.dart';

class ExamDetailsController extends GetxController {
  final args = Get.arguments as List;
  late Exam exam;
  @override
  void onInit() {
    exam = args[1];
    super.onInit();
  }

  void updateQuestionInFirebase(int index, Question newQuestion) async {
    try {
      // Get the reference to the exam document in Firebase
      var examRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args[0])
          .collection('exams')
          .doc(args[1].id);

      // Get the question data from the exam document
      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      // Update the question data with the new question
      questionDataList[index] = newQuestion.toJson();

      // Update the exam document in Firebase with the updated question data
      await examRef.update({'questions': questionDataList});
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void editQuestion(int index, Question newQuestion) {
    args[1].questions[index] = newQuestion;
    updateQuestionInFirebase(index, newQuestion);
    update();
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  void showEditQuestionSheet(int index) async {
    // Get the current question data
    Question question = exam.questions[index];

    // Show a dialog with text fields for editing the question data
    TextEditingController questionController =
        TextEditingController(text: question.question);
    TextEditingController rightAnswerController =
        TextEditingController(text: question.rightAnswer);
    TextEditingController wrongAnswer1Controller =
        TextEditingController(text: question.wrongAnswers![0]);
    TextEditingController wrongAnswer2Controller =
        TextEditingController(text: question.wrongAnswers![1]);
    TextEditingController wrongAnswer3Controller =
        TextEditingController(text: question.wrongAnswers![2]);

    bool? result = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Question'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(
                    labelText: 'Question',
                  ),
                ),
                TextField(
                  controller: rightAnswerController,
                  decoration: const InputDecoration(
                    labelText: 'Right Answer',
                  ),
                ),
                TextField(
                  controller: wrongAnswer1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Wrong Answer 1',
                  ),
                ),
                TextField(
                  controller: wrongAnswer2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Wrong Answer 2',
                  ),
                ),
                TextField(
                  controller: wrongAnswer3Controller,
                  decoration: const InputDecoration(
                    labelText: 'Wrong Answer 3',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Create a new Question object with the updated data
                Question newQuestion = Question(
                  id: question.id,
                  image: question.image,
                  question: questionController.text,
                  rightAnswer: rightAnswerController.text,
                  wrongAnswers: [
                    wrongAnswer1Controller.text,
                    wrongAnswer2Controller.text,
                    wrongAnswer3Controller.text,
                  ],
                );

                // Update the question in Firebase
                updateQuestionInFirebase(index, newQuestion);

                Navigator.pop(context, true);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

// markes for student  done
//  and teacher  done
// end exam for student done
// sign in handling done
// screens connecting done
// log out
// edit exam for teacher done 0.5

// ui beatufing
// error handling
// student profile
// clean & orgs code

}
