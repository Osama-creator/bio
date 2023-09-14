import 'package:bio/app/modules/students_league/controllers/students_league_controller.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentsLeagueController>();
    return Column(
      children: [
        Card(
          color: AppColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.studentName,
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    Card(
                      color: AppColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          controller.studentDesc.isEmpty
                              ? "- - - - - - -"
                              : controller.studentDesc,
                          style: const TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      "r/f ${controller.studentStudentRF}",
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${controller.examsCount} امتحان",
                      style: const TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FantasyUI extends StatelessWidget {
  const FantasyUI({
    super.key,
    required this.avg,
    required this.myPoints,
    required this.heighst,
  });
  final int heighst;
  final int myPoints;
  final int avg;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              heighst.toString(),
              style: const TextStyle(color: AppColors.primary, fontSize: 40),
            ),
            const Text(
              "الأعلى",
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        Card(
          color: AppColors.primary,
          child: Padding(
            padding: EdgeInsets.all(context.height * 0.04),
            child: Column(
              children: [
                Text(
                  myPoints.toString(),
                  style: const TextStyle(color: AppColors.grey, fontSize: 40),
                ),
                const Text(
                  "نقاط الأسبوع",
                  style: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Text(
              avg.toString(),
              style: const TextStyle(color: AppColors.primary, fontSize: 40),
            ),
            const Text(
              "المتوسط",
              style: TextStyle(color: AppColors.primary, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
