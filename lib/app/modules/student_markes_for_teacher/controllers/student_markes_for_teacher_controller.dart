import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:bio/app/services/user_marks_league.dart';
import 'package:get/get.dart';

class StudentMarkesForTeacherController extends GetxController {
  final args = Get.arguments as List<dynamic>;
  bool isLoading = false;
  var marksList = <Mark>[];
  final marksService = MarksAndLeague();
  Future<void> getMarksData() async {
    isLoading = true;
    try {
      marksList = await marksService.getMarks(gradeId: args[1]!.id, examId: args[0]!.id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getMarksData();
    super.onInit();
  }
}
