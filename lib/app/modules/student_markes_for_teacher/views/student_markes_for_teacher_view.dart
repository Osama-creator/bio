import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_markes_for_teacher_controller.dart';

class StudentMarkesForTeacherView extends GetView<StudentMarkesForTeacherController> {
  const StudentMarkesForTeacherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("درجات الطلاب"),
          centerTitle: true,
        ),
        body: GetBuilder<StudentMarkesForTeacherController>(
          init: controller,
          builder: (_) {
            return controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.marksList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          elevation: 10,
                          color: AppColors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(controller.marksList[index].studentName),
                                      Text(
                                          "${controller.marksList[index].studentMark}/${controller.marksList[index].examMark}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              heroTag: "delete all ",
              onPressed: () {
                // Show bottom sheet confirmation dialog
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200, // Adjust height as needed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'هل أنت متأكد من رغبتك في حذف الكل؟',
                            style: TextStyle(fontSize: 18, color: AppColors.grey),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.deleteAllMarksController();
                                  Navigator.pop(context); // Close bottom sheet
                                },
                                child: const Text('نعم'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close bottom sheet
                                },
                                child: const Text('لا'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              backgroundColor: AppColors.primary,
              label: Text(
                "حذف الكل",
                style: context.textTheme.bodyLarge!.copyWith(fontSize: 16, color: AppColors.white),
              ),
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.white,
              ),
            ),
          ],
        ));
  }
}
