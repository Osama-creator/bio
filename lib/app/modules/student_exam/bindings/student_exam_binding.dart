import 'package:get/get.dart';

import '../controllers/student_exam_controller.dart';

class StudentExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentExamController>(
      () => StudentExamController(),
    );
  }
}
