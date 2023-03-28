import 'package:get/get.dart';

import '../controllers/grades_list_controller.dart';

class GradesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GradesListController>(
      () => GradesListController(),
    );
  }
}
