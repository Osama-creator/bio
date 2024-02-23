import 'dart:developer';

import 'package:bio/app/data/models/question_model.dart';
import 'package:bio/app/modules/create_exam/controllers/create_exam_controller.dart';
import 'package:get/get.dart';

class MixinService extends GetxService {
  List<QuestionC> questionFromList = [];

  void clearQuestionList() {
    questionFromList.clear();
  }

  void removQuesion(QuestionC questionC) {
    questionFromList.remove(questionC);
  }
}

mixin AddExistQuestions on GetxController {
  final MixinService mixinService = Get.find<MixinService>();
  List<QuestionC> get questionFromList => mixinService.questionFromList;
  List<Question> questionsLista = [];
  bool questionsHasSelected = false;
  void selectQuestion(Question question) {
    question.isSelected = !question.isSelected;

    if (question.isSelected) {
      if (!questionsLista.any((q) => q.id == question.id)) {
        questionsLista.add(question);
        log(questionsLista.length.toString());
        update();
      }
    } else {
      questionsLista.removeWhere((q) => q.id == question.id);
      log(questionsLista.length.toString());
      update();
    }
  }

  void selectAll(List<Question> selectedList) {
    if (questionsHasSelected) {
      for (var question in selectedList) {
        question.isSelected = false;
        questionsLista.removeWhere((q) => q.id == question.id);
      }
      questionsHasSelected = false;
      update();
    } else {
      for (var question in selectedList) {
        question.isSelected = true;
        questionsLista.removeWhere((q) => q.id == question.id);
        questionsLista.add(question);
      }
      update();
      questionsHasSelected = true;
    }
  }

  void fromQuestionToFrom() {
    // questionsFrormList.clear(); // Clear the existing list
    for (var question in questionsLista) {
      // Create a new instance of QuestionC
      QuestionC questionC = QuestionC();
      // Populate the fields of the QuestionC object
      questionC.questionC.text = question.question ?? '';
      questionC.rightAnswerC.text = question.rightAnswer ?? '';
      questionC.wrongAnswer1C.text = question.wrongAnswers?[0] ?? '';
      questionC.wrongAnswer2C.text = question.wrongAnswers?[1] ?? '';
      questionC.wrongAnswer3C.text = question.wrongAnswers?[2] ?? '';
      questionC.imageString = question.image ?? '';
      // Add the populated QuestionC object to the list
      questionFromList.add(questionC);
    }
    Get.find<CreateExamController>().update();
  }
}
