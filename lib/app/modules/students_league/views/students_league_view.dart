import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/utils/enums.dart';
import '../controllers/students_league_controller.dart';
import 'leagues.dart/bronze.dart';

class StudentsLeagueView extends StatelessWidget {
  const StudentsLeagueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentsLeagueController>(
      init: StudentsLeagueController(),
      builder: (controller) {
        Widget leagueWidget;
        switch (controller.userLeage) {
          case League.BRONZE:
            leagueWidget = LeagueWidget(
              controller: controller,
              leagueSecondColor: Colors.brown[50]!,
              imageNum: "1",
              leagueFirstColor: Colors.brown,
              leagueName: 'الدوري البرونزي',
              level: "الأول",
              students: controller.leagueStudents[League.BRONZE]!,
            );
            break;
          case League.SILVER:
            leagueWidget = LeagueWidget(
              controller: controller,
              leagueSecondColor: Colors.grey[100]!,
              imageNum: "2",
              leagueFirstColor: Colors.black54,
              leagueName: 'الدوري الفضي ',
              level: "الثاني",
              students: controller.leagueStudents[League.SILVER]!,
            );
            break;
          case League.GOLD:
            leagueWidget = LeagueWidget(
              controller: controller,
              leagueSecondColor: Colors.white,
              imageNum: "4",
              leagueFirstColor: Colors.orange,
              leagueName: 'الدوري الذهبي ',
              level: "الرابع",
              students: controller.leagueStudents[League.GOLD]!,
            );
            break;
          case League.PLATINUM:
            leagueWidget = LeagueWidget(
              controller: controller,
              leagueSecondColor: Colors.blueGrey[50]!,
              imageNum: "3",
              leagueFirstColor: Colors.blueGrey,
              leagueName: 'الدوري البلاتيني  ',
              level: "الثالث",
              students: controller.leagueStudents[League.PLATINUM]!,
            );
            break;
          case League.ACE:
            leagueWidget = LeagueWidget(
              controller: controller,
              leagueSecondColor: Colors.red[50]!,
              imageNum: "5",
              leagueFirstColor: Colors.red,
              leagueName: 'الماسى',
              level: "المستوى الخامس",
              students: controller.leagueStudents[League.ACE]!,
            );
            break;
          case League.CROWN:
            leagueWidget = LeagueWidget(
              controller: controller,
              leagueSecondColor: Colors.red[50]!,
              imageNum: "6",
              leagueFirstColor: Colors.purple,
              leagueName: 'التااج',
              imageScale: 2,
              level: "المستوى الممتاز",
              students: controller.leagueStudents[League.CROWN]!,
            );
            break;
          case League.CONQUEROR:
            leagueWidget = LeagueWidget(
              controller: controller,
              leagueSecondColor: Colors.red[50]!,
              imageNum: "7",
              leagueFirstColor: Colors.blue,
              leagueName: 'الكونكر',
              level: "الافضل",
              students: controller.leagueStudents[League.CONQUEROR]!,
            );
        }

        return leagueWidget;
      },
    );
  }
}
