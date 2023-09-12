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
  int userPoints = 0;
  League userLeage = League.BRONZE;
  League determineLeague(int points) {
    if (points < 100) {
      return League.BRONZE;
    } else if (points < 200) {
      return League.SILVER;
    } else if (points < 300) {
      return League.GOLD;
    } else if (points < 400) {
      return League.PLATINUM;
    } else if (points < 600) {
      return League.ACE;
    } else if (points < 500) {
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
    userPoints = userDataMap['marks'];
    userLeage = determineLeague(userPoints);
    update();
    getData();
    super.onInit();
  }
}
