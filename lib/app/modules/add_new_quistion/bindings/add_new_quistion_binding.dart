import 'package:get/get.dart';

import '../controllers/add_new_quistion_controller.dart';

class AddNewQuistionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewQuistionController>(
      () => AddNewQuistionController(),
    );
  }
}
