import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/services/user_local.dart';
import 'package:get/get.dart';

import '../../../../config/utils/enums.dart';

mixin LeagueManagingController on GetxController {
  List<Student> studentList = [];
  String studentGrade = "";
  League userLeage = League.BRONZE;
  final userDataService = UserDataService();
  bool isThirdScStudent() {
    bool myVar = false;
    if (studentGrade == "٣ ثانوي" || studentGrade == "3rd secondary") {
      myVar = true;
    }
    return myVar;
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

  @override
  void onInit() async {
    final student = await userDataService.getUserFromLocal();
    studentGrade = student!.grade;
    update();
    super.onInit();
  }
}
