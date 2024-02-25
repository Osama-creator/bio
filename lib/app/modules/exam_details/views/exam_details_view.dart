import 'dart:developer';

import 'package:bio/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../controllers/exam_details_controller.dart';

class ExamDetailsView extends GetView<ExamDetailsController> {
  const ExamDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamDetailsController>(
        init: controller,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text(controller.exam.name),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      controller.editExamName();
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width * 0.02, vertical: 16),
                  child: Container(
                    height: context.height * 0.06,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary, width: 0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Center(
                        child: controller.isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                'تكرار الامتحان في صف اخر ',
                                style: context.textTheme.titleLarge!
                                    .copyWith(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                      ),
                      onTap: () async {
                        controller.showGradeSelectionBottomSheet(context);
                        log(controller.selectedGrade!.name);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.questionDataList.length,
                    itemBuilder: (context, index) {
                      final question = controller.questionDataList[index];
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: InkWell(
                          onTap: () {
                            //? args[2]  meens that i want to select quseions not edit or delete
                            if (controller.args[2]) {
                              controller.selectQuestion(question);
                            }
                          },
                          child: Card(
                            elevation: 10,
                            color: question.isSelected ? AppColors.primary : const Color.fromARGB(255, 156, 169, 187),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  if (!controller.args[2])
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.removeQuestion(index);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.offAndToNamed(Routes.EDIT_QUISTION,
                                                  arguments: [...controller.args, question, index]);
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: AppColors.white,
                                            ))
                                      ],
                                    ),
                                  Text(question.question!,
                                      style: context.textTheme.titleLarge!.copyWith(
                                          color: question.isSelected ? AppColors.grey : AppColors.primary,
                                          fontWeight: FontWeight.bold)),
                                  if (question.image!.isNotEmpty) ...[
                                    SizedBox(
                                        height: context.height * 0.2,
                                        width: context.width * 0.8,
                                        child: Image.network(
                                          question.image!,
                                          fit: BoxFit.contain,
                                        )),
                                  ],
                                  Divider(
                                    color: question.isSelected ? Colors.white : AppColors.primary,
                                  ),
                                  Text(question.rightAnswer),
                                  Divider(
                                    color: question.isSelected ? Colors.white : AppColors.primary,
                                  ),
                                  Text(question.wrongAnswers![0]),
                                  Divider(
                                    color: question.isSelected ? Colors.white : AppColors.primary,
                                  ),
                                  Text(question.wrongAnswers![1]),
                                  Divider(
                                    color: question.isSelected ? Colors.white : AppColors.primary,
                                  ),
                                  Text(question.wrongAnswers![2]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: controller.args[2]
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton.extended(
                        heroTag: "select all",
                        onPressed: () {
                          controller.selectAll(controller.questionDataList);
                        },
                        backgroundColor: controller.questionsHasSelected ? AppColors.white : AppColors.primary,
                        label: Text(
                          "اختيار الكل",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontSize: 16,
                              color: controller.questionsHasSelected ? AppColors.primary : AppColors.white),
                        ),
                        icon: Icon(
                          Icons.select_all,
                          color: controller.questionsHasSelected ? AppColors.primary : AppColors.white,
                        ),
                      ),
                      if (controller.questionsLista.isNotEmpty)
                        FloatingActionButton.extended(
                          heroTag: "done",
                          onPressed: () async {
                            controller.fromQuestionToFrom();
                            Get.back();
                            Get.back();
                          },
                          backgroundColor: AppColors.white,
                          label: Padding(
                            padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
                            child: Text(
                              "حفظ   ${controller.questionsLista.length}",
                              style: context.textTheme.bodyLarge!.copyWith(fontSize: 16, color: AppColors.primary),
                            ),
                          ),
                          icon: const Icon(
                            Icons.save,
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  )
                : controller.selectedGrade == null
                    ? FloatingActionButton.extended(
                        heroTag: "create11 qustion",
                        onPressed: () {
                          Get.offAndToNamed(Routes.ADD_NEW_QUISTION, arguments: controller.args);
                          // controller.showAddQuestionSheet(initialQuestion: null);
                        },
                        backgroundColor: AppColors.primary,
                        label: Text(
                          "إضافة سؤال",
                          style: context.textTheme.bodyLarge!.copyWith(fontSize: 16),
                        ),
                        icon: const Icon(Icons.add),
                      )
                    : FloatingActionButton.extended(
                        heroTag: "add exam",
                        onPressed: () {
                          controller.addExamToAnotherGrade();
                          log(controller.selectedGrade!.name);
                        },
                        backgroundColor: AppColors.primary,
                        label: Text(
                          "حفظ الامتحان في الصف ",
                          style: context.textTheme.bodyLarge!.copyWith(fontSize: 16),
                        ),
                        icon: const Icon(Icons.save),
                      ),
          );
        });
  }
}
