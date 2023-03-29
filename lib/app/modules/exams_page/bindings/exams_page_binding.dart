import 'package:get/get.dart';

import '../controllers/exams_page_controller.dart';

class ExamsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamsPageController>(
      () => ExamsPageController(),
    );
  }
}
