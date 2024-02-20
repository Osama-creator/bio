import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/services/user_local.dart';
import 'package:bio/app/services/user_marks_league.dart';
import 'package:get/get.dart';

class StudentMarkesController extends GetxController {
  final exam = Get.arguments;
  bool isLoading = false;
  var marksList = <Mark>[];
  final marksService = MarksAndLeague();
  Student? student;

  Future<void> getStudentMarks() async {
    isLoading = true;
    try {
      student = await UserDataService().getUserFromLocal();
      marksList = await marksService.getMarks(gradeId: student!.gradeId, examId: exam.id);
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
    getStudentMarks();
    super.onInit();
  }
}
