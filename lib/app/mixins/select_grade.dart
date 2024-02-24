import 'dart:developer';

import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:bio/app/services/utils_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SelectGrade on GetxController {
  var gradeList = <GradeItem>[];
  GradeItem? selectedGrade;
  final utilsService = UtilsService();

  Future<void> getGrades() async {
    try {
      gradeList = await utilsService.getGradesFromApi();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void showGradeSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: gradeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final grade = gradeList[index];
                    return ListTile(
                      title: Text(grade.name),
                      onTap: () {
                        selectedGrade = grade;
                        update();
                        Get.back();
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('إغلاق'),
              ),
            ],
          ),
        );
      },
    );
  }
}
