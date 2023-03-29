import 'package:get/get.dart';

import '../controllers/create_exam_controller.dart';

class CreateExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateExamController>(
      () => CreateExamController(),
    );
  }
}
