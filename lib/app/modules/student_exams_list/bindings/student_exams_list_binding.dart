import 'package:get/get.dart';

import '../controllers/student_exams_list_controller.dart';

class StudentExamsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentExamsListController>(
      () => StudentExamsListController(),
    );
  }
}
