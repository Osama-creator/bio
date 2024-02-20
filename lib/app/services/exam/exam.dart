import 'package:bio/app/data/models/exam_model.dart';
import 'package:bio/app/data/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ExamService {
  Future<void> addExamDocument(String gradeId, Map<String, dynamic> examData) async {
    CollectionReference examCollection =
        FirebaseFirestore.instance.collection('grades').doc(gradeId).collection('exams');

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

  Future<List<Exam>> getExams(String gradeId, bool isTeacher) async {
    var examList = <Exam>[];

    final examsSnapshot = await FirebaseFirestore.instance
        .collection('grades')
        .doc(gradeId)
        .collection('exams')
        .where('is_active', isEqualTo: true)
        .get();
    final examsSnapshotforTeacher =
        await FirebaseFirestore.instance.collection('grades').doc(gradeId).collection('exams').get();
    examList.clear();
    for (var examDoc in isTeacher ? examsSnapshotforTeacher.docs : examsSnapshot.docs) {
      final questionDataList = examDoc['questions'];
      final questionList = questionDataList.map<Question>((questionData) {
        return Question.fromJson(questionData);
      }).toList();
      final exam = Exam.fromJson(
        examDoc.data(),
        examDoc.id,
        questionList,
      );
      examList.add(exam);
    }
    examList.sort((a, b) => a.date.compareTo(b.date));
    return examList;
  }
}
