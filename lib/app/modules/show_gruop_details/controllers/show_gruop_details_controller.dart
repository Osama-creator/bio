import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import '../../../routes/app_pages.dart';

class ShowGruopDetailsController extends GetxController {
  final args = Get.arguments as Group;
  void navigate() {
    Get.toNamed(
      Routes.SHOW_GRUOP_DETAILS,
      arguments: args,
    );
  }
}
