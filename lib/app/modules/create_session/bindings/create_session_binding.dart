import 'package:get/get.dart';

import '../controllers/create_session_controller.dart';

class CreateSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSessionController>(
      () => CreateSessionController(),
    );
  }
}
