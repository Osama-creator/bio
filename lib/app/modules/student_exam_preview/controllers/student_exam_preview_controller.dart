import 'package:get/get.dart';

import '../../../data/models/question_model.dart';

class StudentExamPreviewController extends GetxController {
  final args = Get.arguments as List;
  late List<Question> questions;
  late int result;
  @override
  void onInit() {
    questions = args[0];
    result = args[1];
    super.onInit();
  }
}
