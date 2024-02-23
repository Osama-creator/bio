import 'package:bio/app/data/models/exam_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherExamService {
  Future<List<Exam>> deleteExam({required String examId, required String gradeId}) async {
    var examList = <Exam>[];

    await FirebaseFirestore.instance.collection('grades').doc(gradeId).collection('exams').doc(examId).delete();
    examList.removeWhere((exam) => exam.id == examId);
    return examList;
  }

  Future<void> updateExamActivation({required String examId, required bool isActive, required String gradeId}) async {
    await FirebaseFirestore.instance
        .collection('grades')
        .doc(gradeId)
        .collection('exams')
        .doc(examId)
        .update({'is_active': isActive});
  }
}
