import 'dart:developer';

import 'package:bio/app/data/models/exam_model.dart';
import 'package:bio/app/mixins/add_exist_questoins.dart';
import 'package:bio/app/views/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/question_model.dart';

class ExamDetailsController extends GetxController with AddExistQuestions {
  final args = Get.arguments as List;
  TextEditingController examNameCont = TextEditingController();
  RxList<Question> questionDataList = RxList<Question>([]);
  late Exam exam;
  @override
  void onInit() {
    exam = args[1];
    questionDataList.addAll(args[1].questions!);
    update();
    super.onInit();
  }

  void updateQuestionInFirebase(int index, Question newQuestion) async {
    try {
      var examRef = FirebaseFirestore.instance.collection('grades').doc(args[0]).collection('exams').doc(args[1].id);

      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      questionDataList[index] = newQuestion.toJson();

      await examRef.update({'questions': questionDataList});
      Get.snackbar('تم', "تم التعديل بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void editQuestion(int index, Question newQuestion) {
    args[1].questions[index] = newQuestion;
    updateQuestionInFirebase(index, newQuestion);
    questionDataList[index] = newQuestion; // update the question in the RxList
    update(); // rebuild the widget with the updated question
  }

  Future<void> updateName() async {
    try {
      var examRef = FirebaseFirestore.instance.collection('grades').doc(args[0]).collection('exams').doc(args[1].id);
      await examRef.update(({'name': exam.name}));
      update();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void editExamName() {
    examNameCont.text = exam.name;
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextFeild(
                  width: context.width,
                  controller: examNameCont,
                  hintText: 'Edit exma name',
                  labelText: "exma Name",
                  onFieldSubmitted: (_) {
                    false;
                  },
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              child: Text("Update", style: context.textTheme.displayLarge),
              onPressed: () {
                exam.name = examNameCont.text.trim();
                updateName();
                examNameCont.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void removeQuestion(int index) async {
    try {
      var examRef = FirebaseFirestore.instance.collection('grades').doc(args[0]).collection('exams').doc(args[1].id);

      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      questionDataList.remove(questionDataList[index]);
      update();
      questionDataList.removeAt(index);
      await examRef.update({'questions': questionDataList});
      Get.snackbar('تم', "تم الحذف بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void addQuestion(Question newQuestion) async {
    try {
      var examRef = FirebaseFirestore.instance.collection('grades').doc(args[0]).collection('exams').doc(args[1].id);

      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      questionDataList.add(newQuestion);
      update();
      questionDataList.add(newQuestion.toJson());

      await examRef.update({'questions': questionDataList});
      Get.snackbar('تم', "تمت الإضافة بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }
}
