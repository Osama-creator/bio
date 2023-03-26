import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import '../../../routes/app_pages.dart';

class ShowGruopDetailsController extends GetxController {
  final args = Get.arguments as Group;
  void navigate() {
    Get.offAndToNamed(
      Routes.CREATE_SESSION,
      arguments: args,
    );
  }

  int totalAfterdiscount(int index) {
    return (args.students![index].price! /
            int.parse(args.sessions!) *
            args.students![index].absence)
        .toInt();
  }
}
