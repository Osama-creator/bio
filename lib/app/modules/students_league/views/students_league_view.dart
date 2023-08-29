import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/students_league_controller.dart';

class StudentsLeagueView extends GetView<StudentsLeagueController> {
  const StudentsLeagueView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<StudentsLeagueController>(
            init: controller,
            builder: (_) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.studentList.isEmpty
                      ? const Center(
                          child: Text("لا يوجد طلاب حتى الان"),
                        )
                      : ListView.builder(
                          itemCount: controller.studentList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: index == 0
                                  ? Colors.amber[500]
                                  : AppColors.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "(${(index + 1).toString()})",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: index == 0
                                                  ? AppColors.black
                                                  : AppColors.white),
                                        ),
                                        SizedBox(
                                          width: context.width * 0.2,
                                        ),
                                        Text(
                                          controller.studentList[index].name,
                                          style: TextStyle(
                                              color: index == 0
                                                  ? AppColors.black
                                                  : AppColors.white),
                                        ),
                                        const Spacer(),
                                        if (index == 0) ...[
                                          const Card(
                                            child: Padding(
                                              padding: EdgeInsets.all(4),
                                              child: Text("💪💪💪"),
                                            ),
                                          ),
                                          const Spacer()
                                        ]
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          "عدد النقاط",
                                          style: TextStyle(
                                              color: index == 0
                                                  ? AppColors.black
                                                  : AppColors.white),
                                        ),
                                        SizedBox(
                                          width: context.width * 0.1,
                                        ),
                                        Text(
                                          controller.studentList[index].marks!
                                              .toString(),
                                          style: TextStyle(
                                              color: index == 0
                                                  ? AppColors.black
                                                  : AppColors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
            }));
  }
}
