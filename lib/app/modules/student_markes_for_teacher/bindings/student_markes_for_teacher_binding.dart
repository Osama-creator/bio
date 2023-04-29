import 'package:get/get.dart';

import '../controllers/student_markes_for_teacher_controller.dart';

class StudentMarkesForTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentMarkesForTeacherController>(
      () => StudentMarkesForTeacherController(),
    );
  }
}
