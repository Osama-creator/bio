import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../controllers/exam_details_controller.dart';

class ExamDetailsView extends GetView<ExamDetailsController> {
  const ExamDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.exam.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.exam.questions.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.showEditQuestionSheet(
                  index: index,
                  isNew: false,
                  initialQuestion: controller.exam.questions[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                elevation: 10,
                color: const Color.fromARGB(255, 156, 169, 187),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(controller.exam.questions[index].question!),
                      if (controller
                          .exam.questions[index].image!.isNotEmpty) ...[
                        SizedBox(
                            height: context.height * 0.2,
                            width: context.width * 0.8,
                            child: Image.network(
                              controller.args[1].questions[index].image!,
                              fit: BoxFit.contain,
                            )),
                      ],
                      Text(controller.exam.questions[index].rightAnswer),
                      Text(controller.exam.questions[index].wrongAnswers![0]),
                      Text(controller.exam.questions[index].wrongAnswers![1]),
                      Text(controller.exam.questions[index].wrongAnswers![2]),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton.extended(
            heroTag: "create qustion",
            onPressed: () {
              controller.showEditQuestionSheet(index: 1, isNew: true);
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
  }
}
