import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import 'package:intl/intl.dart';

import '../../../data/models/student_model.dart';

class CreateSessionController extends GetxController {
  final args = Get.arguments as Group;
  bool checked = false;

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var checkedStudents = <Studen, bool>{};

  bool isChecked(Studen student) {
    return checkedStudents[student] ?? false;
  }

  void setChecked(Studen student, bool value) {
    checkedStudents[student] = value;
    update();
  }
}
