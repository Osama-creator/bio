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
            ),
            body: ListView.builder(
              itemCount: controller.questions.length,
              itemBuilder: (context, index) {
                final question = controller.questions[index];
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    elevation: 10,
                    color: const Color.fromARGB(255, 156, 169, 187),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
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
                                    controller.showEditQuestionSheet(
                                        index: index,
                                        isNew: false,
                                        initialQuestion: question);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.white,
                                  ))
                            ],
                          ),
                          Text(question.question!,
                              style: context.textTheme.headline6!.copyWith(
                                  color: AppColors.primary,
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
                          const Divider(),
                          Text(question.rightAnswer),
                          const Divider(),
                          Text(question.wrongAnswers![0]),
                          const Divider(),
                          Text(question.wrongAnswers![1]),
                          const Divider(),
                          Text(question.wrongAnswers![2]),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.extended(
                  heroTag: "create qustion",
                  onPressed: () {
                    controller.showAddQuestionSheet(initialQuestion: null);
                  },
                  backgroundColor: AppColors.primary,
                  label: Text(
                    "إضافة سؤال",
                    style: context.textTheme.bodyText1!.copyWith(fontSize: 16),
                  ),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          );
        });
  }
}
