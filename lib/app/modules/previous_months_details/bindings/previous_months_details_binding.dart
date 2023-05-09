import 'package:get/get.dart';

import '../controllers/previous_months_details_controller.dart';

class PreviousMonthsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviousMonthsDetailsController>(
      () => PreviousMonthsDetailsController(),
    );
  }
}
