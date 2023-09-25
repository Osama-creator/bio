import 'package:get/get.dart';

import '../controllers/student_exam_preview_controller.dart';

class StudentExamPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentExamPreviewController>(
      StudentExamPreviewController(),
    );
  }
}
