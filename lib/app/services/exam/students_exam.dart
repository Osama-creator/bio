import 'package:bio/app/data/models/exam_model.dart';
import 'package:bio/app/data/models/mark.dart';
import 'package:bio/app/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StdnExamService {
  Future<void> uploadMarkAndUpdateUserData(Mark mark, String gradeId, String examId) async {
    final markesCollection = FirebaseFirestore.instance
        .collection('grades')
        .doc(gradeId)
        .collection('exams')
        .doc(examId)
        .collection('markes');
    markesCollection.add(mark.toJson());
  }

  Future<QuerySnapshot> getExistingMarkSnapshot(Student stdn, Exam exam) async {
    return await FirebaseFirestore.instance
        .collection('grades')
        .doc(stdn.gradeId)
        .collection('exams')
        .doc(exam.id)
        .collection('markes')
        .where('email', isEqualTo: stdn.email)
        .get();
  }

  Future<QuerySnapshot> getUserSnapshot(String email) async {
    return await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
  }

  Future<void> updateUserData(documentId, userPerformance) async {
    await FirebaseFirestore.instance.collection('users').doc(documentId).update({
      'marks': userPerformance['userMarks'],
      'w_points': userPerformance['userWPoints'],
      'wrong_answers': userPerformance['userWrongAns'],
      'right_answers': userPerformance['userRightAns'],
      'exam_count': userPerformance['userExamsCount'],
      'nickname': userPerformance['userNickname'],
    });
  }
}
