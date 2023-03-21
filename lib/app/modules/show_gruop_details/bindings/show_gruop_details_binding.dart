import 'package:get/get.dart';

import '../controllers/show_gruop_details_controller.dart';

class ShowGruopDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowGruopDetailsController>(
      () => ShowGruopDetailsController(),
    );
  }
}
