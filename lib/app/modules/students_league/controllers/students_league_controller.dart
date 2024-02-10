import 'dart:convert';
import 'dart:developer';

import 'package:bio/app/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/utils/enums.dart';

class StudentsLeagueController extends GetxController {
  bool isLoading = false;
  List<Student> studentList = [];
  String studentName = "";
  int studentStudentRightAns = 0;
  int studentStudentWrongAns = 0;
  double studentStudentRF = 0;
  String studentDesc = "";
  String studentGrade = "";
  int examsCount = 0;
  int userPoints = 0;
  int userWPoints = 0;

  League userLeage = League.BRONZE;
  bool isThirdScStudent() {
    bool myVar = false;
    if (studentGrade == "٣ ثانوي" || studentGrade == "3rd secondary") {
      myVar = true;
    }
    return myVar;
  }

  League determineLeague(int points) {
    if (points < (isThirdScStudent() ? 300 : 100)) {
      return League.BRONZE;
    } else if (points < (isThirdScStudent() ? 500 : 200)) {
      return League.SILVER;
    } else if (points < (isThirdScStudent() ? 800 : 300)) {
      return League.GOLD;
    } else if (points < (isThirdScStudent() ? 1000 : 400)) {
      return League.PLATINUM;
    } else if (points < (isThirdScStudent() ? 1200 : 600)) {
      return League.ACE;
    } else if (points < (isThirdScStudent() ? 1500 : 700)) {
      return League.CROWN;
    } else {
      return League.CONQUEROR;
    }
  }

  Future<void> getData() async {
    isLoading = true;
    update();
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData == null) {
      throw Exception("User data not found in SharedPreferences");
    }
    final userDataMap = jsonDecode(userData);
    final userEmail = userDataMap['email'];

    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: userEmail).get();
    final documentId = userSnapshot.docs[0].id;
    await updateMark(userDataMap, documentId);
    final userGrade = userDataMap['grade_id'];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').where('grade_id', isEqualTo: userGrade).get();
      studentList.clear();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Student student = Student.fromJson(data);
        studentList.add(student);
      }
      categorizeStudents();
    } catch (e, st) {
      Get.snackbar('Error', e.toString());
      log(st.toString());
    } finally {
      isLoading = false;
      update();
    }
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
        log("Updated sumOfMarks: $sumOfMarks");

        update();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  int getAvg(List<Student> students) {
    int totalPoints = 0;
    int totalStudents = 0;

    for (var std in students) {
      if (std.wPoints != null && std.wPoints! > 0) {
        totalPoints += std.wPoints!;
        totalStudents++;
      }
    }

    if (totalStudents > 0) {
      return totalPoints ~/ totalStudents;
    } else {
      return 0;
    }
  }

  void categorizeStudents() {
    leagueStudents.forEach((league, students) {
      students.clear();
    });
    for (var student in studentList) {
      final league = determineLeague(student.marks ?? 0);
      leagueStudents[league]!.add(student);
    }
    leagueStudents.forEach((league, students) {
      students.sort((a, b) => b.marks!.compareTo(a.marks!));
    });
    update();
  }

  Map<League, List<Student>> leagueStudents = {
    League.BRONZE: [],
    League.SILVER: [],
    League.GOLD: [],
    League.PLATINUM: [],
    League.CONQUEROR: [],
    League.CROWN: [],
  };
  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData == null) {
      throw Exception("User data not found in SharedPreferences");
    }
    final userDataMap = jsonDecode(userData);
    try {
      userPoints = userDataMap['marks'];
      userWPoints = userDataMap['w_points'];
      studentName = userDataMap['name'];
      studentDesc = userDataMap['nickname'];
      studentStudentRightAns = userDataMap['right_answers'];
      studentStudentWrongAns = userDataMap['wrong_answers'];
      examsCount = userDataMap['exam_count'];
      studentGrade = userDataMap['grade'];
      studentStudentRF = studentStudentRightAns / studentStudentWrongAns;
    } catch (e, st) {
      log(st.toString());
    }
    userLeage = determineLeague(userPoints);
    update();
    getData();
    super.onInit();
  }
}
