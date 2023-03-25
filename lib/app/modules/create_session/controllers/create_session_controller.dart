import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import 'package:intl/intl.dart';

class CreateSessionController extends GetxController {
  final args = Get.arguments as Group;

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
}
