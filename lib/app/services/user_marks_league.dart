import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarksAndLeague {
  Future<List<Mark>> getMarks({required String gradeId, required String examId}) async {
    var marksList = <Mark>[];

    QuerySnapshot marksSnapshot = await FirebaseFirestore.instance
        .collection('grades')
        .doc(gradeId)
        .collection('exams')
        .doc(examId)
        .collection('markes')
        .get();
    marksList.clear();
    marksList = marksSnapshot.docs.map((doc) => Mark.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return marksList;
  }

  Future<void> deleteAllMarks({required String gradeId, required String examId}) async {
    QuerySnapshot marksSnapshot = await FirebaseFirestore.instance
        .collection('grades')
        .doc(gradeId)
        .collection('exams')
        .doc(examId)
        .collection('markes')
        .get();

    // Delete each mark document one by one
    for (DocumentSnapshot doc in marksSnapshot.docs) {
      await doc.reference.delete();
    }
    log('All marks deleted successfully');
  }

  Future<void> updateMark(Map<String, dynamic>? userData, String documentId) async {
    try {
      if (userData != null) {
        // Loop through all exams for the current user
        QuerySnapshot exams =
            await FirebaseFirestore.instance.collection('grades').doc(userData['grade_id']).collection('exams').get();

        num sumOfMarks = 0;

        for (var exam in exams.docs) {
          // Loop through all exam marks for the current exam and user
          QuerySnapshot marks = await FirebaseFirestore.instance
              .collection('grades')
              .doc(userData['grade_id'])
              .collection('exams')
              .doc(exam.id)
              .collection('markes')
              .where('email', isEqualTo: userData['email'])
              .get();

          for (var mark in marks.docs) {
            // Retrieve and add the student_mark to the sum
            sumOfMarks += mark['student_mark'] as num;
          }
        }
        // Update the student marks field in the user document
        await FirebaseFirestore.instance.collection('users').doc(documentId).update({'marks': sumOfMarks});
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
