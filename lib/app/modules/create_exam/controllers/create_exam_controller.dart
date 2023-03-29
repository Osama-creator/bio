import 'package:bio/app/data/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateExamController extends GetxController {
  TextEditingController examNameController = TextEditingController();
  RxList<Question> questions = RxList<Question>([]);
  Future<void> createExam() async {}
}
