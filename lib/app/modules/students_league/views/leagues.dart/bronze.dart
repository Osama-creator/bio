import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/modules/students_league/controllers/students_league_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeagueWidget extends StatelessWidget {
  const LeagueWidget({
    Key? key,
    required this.controller,
    required this.imageNum,
    required this.leagueName,
    required this.leagueFirstColor,
    required this.level,
    this.imageScale = 4,
    required this.leagueSecondColor,
    required this.students, // Use the 'students' parameter here
  }) : super(key: key);

  final String imageNum;
  final String level;
  final double imageScale;
  final String leagueName;
  final Color leagueFirstColor;
  final Color leagueSecondColor;
  final List<Student> students; // Use the 'students' parameter here
  final StudentsLeagueController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<StudentsLeagueController>(
        init: controller,
        builder: (_) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : students.isEmpty
                  ? const Center(
                      child: Text("لا يوجد طلاب حتى الان"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "المستوى $level",
                            style: TextStyle(
                              color: leagueFirstColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "assets/images/q$imageNum.png",
                            scale: imageScale,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            leagueName,
                            style: TextStyle(
                                color: leagueFirstColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 27),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                            color: leagueFirstColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "الاسبوع",
                                          style: TextStyle(
                                              color: leagueFirstColor,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "المجموع",
                                          style: TextStyle(
                                              color: leagueFirstColor,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: students
                                .length, // Use the 'students' parameter here
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(children: [
                                      Text(
                                        "(${(index + 1).toString()})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: leagueFirstColor),
                                      ),
                                      SizedBox(
                                        width: context.width * 0.1,
                                      ),
                                      Text(
                                        students[index]
                                            .name, // Use the 'students' parameter here
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                            color: leagueFirstColor),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            students[index].wPoints.toString(),
                                            style: TextStyle(
                                                color: leagueFirstColor),
                                          ),
                                          SizedBox(
                                            width: context.width * 0.12,
                                          ),
                                          Text(
                                            students[index]
                                                .marks!
                                                .toString(), // Use the 'students' parameter here
                                            style: TextStyle(
                                                color: leagueFirstColor),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
