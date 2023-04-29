import 'package:get/get.dart';

import '../controllers/student_markes_controller.dart';

class StudentMarkesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentMarkesController>(
      () => StudentMarkesController(),
    );
  }
}
