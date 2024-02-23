import 'dart:developer';
import 'dart:io';

import 'package:bio/app/mixins/add_exist_questoins.dart';
import 'package:bio/app/services/exam/exam.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../helpers/pick.dart';
import '../../../data/models/exam_model.dart';
import '../../../data/models/grade_item_model.dart';
import '../../../data/models/question_model.dart';

class CreateExamController extends GetxController {
  @override
  final MixinService mixinService = Get.find<MixinService>();
  final args = Get.arguments as GradeItem;
  TextEditingController examNameController = TextEditingController();
  DateTime nowDate = DateTime.now();
  final examService = ExamService();
  bool isLoading = false;
  int uploadedQuestionCount = 0; // Track uploaded questions count
  void addQuestion() {
    mixinService.questionFromList.add(QuestionC());
    update();
  }

  Future<void> createExam() async {
    isLoading = true;
    update();
    String examName = examNameController.text.trim();
    List<Question> examQuestions = [];
    List<Future> uploadTasks = []; // keep track of all the upload tasks

    for (var questionC in mixinService.questionFromList) {
      // pick the image file and start uploading it
      if (questionC.image != null) {
        Reference reference = FirebaseStorage.instance.ref().child(const Uuid().v1());
        final UploadTask uploadTask = reference.putFile(questionC.image!);
        uploadTasks.add(uploadTask.whenComplete(() async {
          questionC.imageString = await reference.getDownloadURL();
          questionC.imageUploaded = true;
          uploadedQuestionCount++;
          update();
          log(questionC.imageString);
        }));
      } else {
        questionC.imageUploaded = false;
      }
    }
    await Future.wait(uploadTasks);
    for (var questionC in mixinService.questionFromList) {
      examQuestions.add(Question(
        question: questionC.questionC.text.trim(),
        rightAnswer: questionC.rightAnswerC.text.trim(),
        wrongAnswers: [
          questionC.wrongAnswer1C.text.trim(),
          questionC.wrongAnswer2C.text.trim(),
          questionC.wrongAnswer3C.text.trim(),
        ],
        image: questionC.imageString,
        id: const Uuid().v1(),
      ));
    }

    Exam newExam = Exam(
      name: examName,
      id: const Uuid().v1(),
      date: nowDate,
      questions: examQuestions,
    );

    try {
      Map<String, dynamic> examData = newExam.toJson();

      await examService.addExamDocument(args.id, examData);
      isLoading = false;
      update();
      Get.back();
    } catch (e, st) {
      log(st.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void getLastQuestionImage(int index) {
    if (index >= 0) {
      File image = mixinService.questionFromList[index - 1].image!;
      mixinService.questionFromList[index].image = image;
      update();
    }
  }
}

class QuestionC {
  TextEditingController questionC = TextEditingController();
  TextEditingController rightAnswerC = TextEditingController();
  TextEditingController wrongAnswer1C = TextEditingController();
  TextEditingController wrongAnswer3C = TextEditingController();
  TextEditingController wrongAnswer2C = TextEditingController();

  String imageString = "";
  late bool imageUploaded;
  File? image;

  Future<void> pickFile() async {
    final tempImage = await Pick.imageFromGallery();
    if (tempImage != null) {
      image = tempImage;
      Get.find<CreateExamController>().update();
    }
  }
}
