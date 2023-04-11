import 'package:get/get.dart';

import '../controllers/exam_details_controller.dart';

class ExamDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamDetailsController>(
      () => ExamDetailsController(),
    );
  }
}
