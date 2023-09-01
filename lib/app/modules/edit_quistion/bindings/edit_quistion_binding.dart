import 'package:get/get.dart';

import '../controllers/edit_quistion_controller.dart';

class EditQuistionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditQuistionController>(
      () => EditQuistionController(),
    );
  }
}
