import 'package:bio/app/data/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ExamService {
  Future<void> addExamDocument(
      String gradeId, Map<String, dynamic> examData) async {
    CollectionReference examCollection = FirebaseFirestore.instance
        .collection('grades')
        .doc(gradeId)
        .collection('exams');

    await examCollection.add(examData);
  }

  Future<void> addQuestion(
    List args,
    DocumentReference examRef,
    String imageString,
    String question,
    String rightAnswer,
    List<String> wrongAnswers,
  ) async {
    try {
      var examData = await examRef.get();
      var questionDataList = examData['questions'];
      Question newQuestion = Question(
        question: question,
        rightAnswer: rightAnswer,
        wrongAnswers: wrongAnswers,
        image: imageString,
        id: const Uuid().v1(),
      );
      questionDataList.add(newQuestion.toJson());
      await examRef.update({'questions': questionDataList});
    } catch (e) {
      rethrow;
    }
  }
}
