import 'dart:developer';

import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:bio/app/views/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../routes/app_pages.dart';

class GradesListController extends GetxController {
  bool isLoading = false;
  TextEditingController gradeNameCont = TextEditingController();
  var gradeList = <GradeItem>[];
  Future<void> createGrade() async {
    String gradeName = gradeNameCont.text.trim();
    GradeItem newGroup = GradeItem(
      name: gradeName,
      id: const Uuid().v1(),
    );
    try {
      isLoading = true;
      update();

      CollectionReference groupCollection =
          FirebaseFirestore.instance.collection('grades');
      await groupCollection.add(newGroup.toJson());
      gradeNameCont.clear();
      getData();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void editGrade(int index) {
    GradeItem grade = gradeList[index];
    gradeNameCont.text = grade.name;

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextFeild(
                  width: context.width,
                  controller: gradeNameCont,
                  hintText: 'Edit grade name',
                  labelText: "Grade Name",
                  onFieldSubmitted: (_) {
                    false;
                  },
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              child: Text("Update", style: context.textTheme.displayLarge),
              onPressed: () {
                grade.name = gradeNameCont.text.trim();
                updateGrade(grade);
                gradeNameCont.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateGrade(GradeItem grade) async {
    isLoading = true;
    update();
    try {
      DocumentReference gradeRef =
          FirebaseFirestore.instance.collection('grades').doc(grade.id);
      await gradeRef.update({'name': grade.name});
      getData();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void deleteGrade(int index) async {
    GradeItem grade = gradeList[index];

    try {
      DocumentReference gradeRef =
          FirebaseFirestore.instance.collection('grades').doc(grade.id);
      await gradeRef.delete();
      getData(); // Refresh the data
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  Future<void> getData() async {
    isLoading = true;
    try {
      QuerySnapshot grades =
          await FirebaseFirestore.instance.collection('grades').get();
      gradeList.clear();
      for (var category in grades.docs) {
        gradeList.add(GradeItem(
          name: category['name'],
          id: category.id,
        ));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void navigate(int index) {
    Get.toNamed(
      Routes.EXAMS_PAGE,
      arguments: gradeList[index],
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
