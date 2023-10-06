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
    final userEmail = userDataMap['grade_id'];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('grade_id', isEqualTo: userEmail)
          .get();
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
