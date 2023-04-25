import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/question_model.dart';

class StudentExamController extends GetxController {
  late PageController pageController;
  final quistionList = Get.arguments as List<Question>;
  int qNumber = 1;
  int qIndex() {
    int n = pageController.hasClients ? pageController.page?.toInt() ?? 0 : 0;
    update();
    return n;
  }

  void selectChoice(String value) {
    final currentQuestion = quistionList[pageController.page!.toInt()];
    currentQuestion.userChoice = value;
    update();
  }

  bool hasNoAnswer() {
    late bool qDidnotAnswerd;
    for (var qAnswer in quistionList) {
      if (qAnswer.userChoice == null) {
        return qDidnotAnswerd = true;
      } else {
        return qDidnotAnswerd = false;
      }
    }
    return qDidnotAnswerd;
  }

  void goToNextPage(int index) {
    if (qNumber < quistionList.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      qNumber++;
    } else {
      if (hasNoAnswer()) {
        Get.snackbar('تحذير', "يوجد اسئله لم يتم الجواب عليها");
      } else {
        //   Get.offAndToNamed(Routes.EXAM_RESULT,
        //       arguments: [quistionList, finalMark()]);
        // }
      }

      update();
    }
  }

  void goToPrevPage(int index) {
    pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    qNumber > 1 ? qNumber-- : null;
    update();
  }

  int finalMark() {
    int mark = 0;
    for (int i = 0; i < quistionList.length; i++) {
      if (quistionList[i].userChoice == quistionList[i].rightAnswer) {
        mark++;
      }
    }
    return mark;
  }

  @override
  void onInit() {
    pageController = PageController();

    super.onInit();
  }
}
