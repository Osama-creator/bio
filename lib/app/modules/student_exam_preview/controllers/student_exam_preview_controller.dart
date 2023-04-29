import 'package:bio/app/data/models/exam_model.dart';
import 'package:get/get.dart';

import '../../../data/models/question_model.dart';

class StudentExamPreviewController extends GetxController {
  final args = Get.arguments as List;
  late List<Question> questions;
  late int result;
  late Exam exam;
  @override
  void onInit() {
    questions = args[0];
    result = args[1];
    exam = args[2];
    super.onInit();
  }
}
