import 'package:get/get.dart';

import '../controllers/videos_page_controller.dart';

class VideosPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VideosPageController>(
      VideosPageController(),
    );
  }
}
