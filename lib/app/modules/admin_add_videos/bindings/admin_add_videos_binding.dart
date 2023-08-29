import 'package:get/get.dart';

import '../controllers/admin_add_videos_controller.dart';

class AdminAddVideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddVideosController>(
      () => AdminAddVideosController(),
    );
  }
}
