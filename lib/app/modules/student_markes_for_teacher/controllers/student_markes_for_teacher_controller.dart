import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:bio/app/services/user_marks_league.dart';
import 'package:bio/helpers/alert.dart';
import 'package:get/get.dart';

class StudentMarkesForTeacherController extends GetxController {
  final args = Get.arguments as List<dynamic>;
  bool isLoading = false;
  var marksList = <Mark>[];
  final marksService = MarksAndLeague();
  Future<void> getMarksData() async {
    isLoading = true;
    try {
      marksList = await marksService.getMarks(gradeId: args[1][0].id, examId: args[0]!.id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteAllMarksController() async {
    isLoading = true;
    update();
    try {
      await marksService.deleteAllMarks(gradeId: args[1][0].id, examId: args[0]!.id);
      marksList.clear();
      Alert.success("👍😎 تم تسويح كل الطلاب ");
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
