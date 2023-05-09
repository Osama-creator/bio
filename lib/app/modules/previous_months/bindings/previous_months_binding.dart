import 'package:get/get.dart';

import '../controllers/previous_months_controller.dart';

class PreviousMonthsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PreviousMonthsController>(
      PreviousMonthsController(),
    );
  }
}
