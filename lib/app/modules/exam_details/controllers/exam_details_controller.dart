import 'dart:developer';

import 'package:bio/app/data/models/exam_model.dart';
import 'package:bio/app/views/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/question_model.dart';

class ExamDetailsController extends GetxController {
  final args = Get.arguments as List;
  TextEditingController examNameCont = TextEditingController();
  RxList<Question> questions = RxList<Question>([]);
  late Exam exam;
  @override
  void onInit() {
    exam = args[1];
    questions.addAll(args[1].questions!);
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
    questions[index] = newQuestion; // update the question in the RxList
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

      questions.remove(questions[index]);
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

      questions.add(newQuestion);
      update();
      questionDataList.add(newQuestion.toJson());

      await examRef.update({'questions': questionDataList});
      Get.snackbar('تم', "تمت الإضافة بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void showEditQuestionSheet({Question? initialQuestion, bool? isNew, int? index}) async {
    Question question = exam.questions[index!];

    TextEditingController questionController = TextEditingController(text: initialQuestion?.question ?? '');
    TextEditingController rightAnswerController = TextEditingController(text: initialQuestion?.rightAnswer ?? '');
    TextEditingController wrongAnswer1Controller = TextEditingController(text: initialQuestion?.wrongAnswers?[0] ?? '');
    TextEditingController wrongAnswer2Controller = TextEditingController(text: initialQuestion?.wrongAnswers?[1] ?? '');
    TextEditingController wrongAnswer3Controller = TextEditingController(text: initialQuestion?.wrongAnswers?[2] ?? '');

    bool? result = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Question'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: context.width * 0.8,
                  child: MyTextFeild(
                    controller: questionController,
                    hintText: "السؤال",
                    labelText: "السؤال",
                  ),
                ),
                MyTextFeild(
                  labelText: "الإجابه الصحيحه",
                  controller: rightAnswerController,
                  hintText: "الإجابه الصحيحه",
                ),
                MyTextFeild(
                  controller: wrongAnswer1Controller,
                  labelText: "الإجابه الخاطئه 1",
                  hintText: "الإجابه الخاطئه 1",
                ),
                MyTextFeild(
                  controller: wrongAnswer2Controller,
                  labelText: "الإجابه الخاطئه 2",
                  hintText: "الإجابه الخاطئه 2",
                ),
                MyTextFeild(
                  controller: wrongAnswer3Controller,
                  labelText: "الإجابه الخاطئه 3",
                  hintText: "الإجابه الخاطئه 3",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('الغاء'),
            ),
            TextButton(
              onPressed: () {
                Question newQuestion = Question(
                  id: question.id ?? const Uuid().v1(),
                  image: question.image ?? "",
                  question: questionController.text,
                  rightAnswer: rightAnswerController.text,
                  wrongAnswers: [
                    wrongAnswer1Controller.text,
                    wrongAnswer2Controller.text,
                    wrongAnswer3Controller.text,
                  ],
                );

                if (initialQuestion == null) {
                  addQuestion(newQuestion);
                } else {
                  editQuestion(index, newQuestion);
                }
                update();
                Navigator.pop(context, true);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      update();
    }
  }

  void showAddQuestionSheet({
    Question? initialQuestion,
  }) async {
    TextEditingController questionController = TextEditingController(text: initialQuestion?.question ?? '');
    TextEditingController rightAnswerController = TextEditingController(text: initialQuestion?.rightAnswer ?? '');
    TextEditingController wrongAnswer1Controller = TextEditingController(text: initialQuestion?.wrongAnswers?[0] ?? '');
    TextEditingController wrongAnswer2Controller = TextEditingController(text: initialQuestion?.wrongAnswers?[1] ?? '');
    TextEditingController wrongAnswer3Controller = TextEditingController(text: initialQuestion?.wrongAnswers?[2] ?? '');

    bool? result = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Question'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: context.width * 0.8,
                  child: MyTextFeild(
                    controller: questionController,
                    hintText: "السؤال",
                    labelText: "السؤال",
                  ),
                ),
                MyTextFeild(
                  labelText: "الإجابه الصحيحه",
                  controller: rightAnswerController,
                  hintText: "الإجابه الصحيحه",
                ),
                MyTextFeild(
                  controller: wrongAnswer1Controller,
                  labelText: "الإجابه الخاطئه 1",
                  hintText: "الإجابه الخاطئه 1",
                ),
                MyTextFeild(
                  controller: wrongAnswer2Controller,
                  labelText: "الإجابه الخاطئه 2",
                  hintText: "الإجابه الخاطئه 2",
                ),
                MyTextFeild(
                  controller: wrongAnswer3Controller,
                  labelText: "الإجابه الخاطئه 3",
                  hintText: "الإجابه الخاطئه 3",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('الغاء'),
            ),
            TextButton(
              onPressed: () {
                Question newQuestion = Question(
                  id: const Uuid().v1(),
                  image: "",
                  question: questionController.text,
                  rightAnswer: rightAnswerController.text,
                  wrongAnswers: [
                    wrongAnswer1Controller.text,
                    wrongAnswer2Controller.text,
                    wrongAnswer3Controller.text,
                  ],
                );

                addQuestion(newQuestion);

                update();
                Navigator.pop(context, true);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      update();
    }
  }
}
