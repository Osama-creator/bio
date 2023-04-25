import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../controllers/student_exam_controller.dart';

class StudentExamView extends GetView<StudentExamController> {
  const StudentExamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<StudentExamController>(
        init: StudentExamController(),
        builder: (controller) {
          int index = controller.qIndex();
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                    "السؤال ${controller.qNumber} من ${controller.quistionList.length}",
                    style: Theme.of(context).textTheme.bodyText1),
                centerTitle: true,
                elevation: 10,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.8,
                      width: w,
                      child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          itemCount: controller.quistionList.length,
                          itemBuilder: (context, index) {
                            return QuestionBody(
                              index: index,
                              quistion:
                                  controller.quistionList[index].question!,
                              image: controller.quistionList[index].image!,
                              list:
                                  controller.quistionList[index].wrongAnswers!,
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (controller.qNumber != 1) ...[
                          SizedBox(
                            width: context.width * 0.2,
                            height: context.width * 0.12,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.goToPrevPage(index);
                                },
                                child: const Text("السابق")),
                          ),
                        ],
                        SizedBox(
                          width: controller.qNumber != 1
                              ? context.width * 0.7
                              : context.width * 0.8,
                          height: context.width * 0.12,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.goToNextPage(index);
                              },
                              child: Text(controller.qNumber ==
                                      controller.quistionList.length
                                  ? "إنهاء"
                                  : "التالي")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class QuestionBody extends StatelessWidget {
  final String quistion;
  final int index;
  final List<String> list;
  final String image;

  const QuestionBody(
      {Key? key,
      required this.index,
      required this.quistion,
      required this.list,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<StudentExamController>(
        init: StudentExamController(),
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: context.height * 0.4,
                  width: context.width * 0.9,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          quistion,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (image.isNotEmpty) ...[
                          SizedBox(
                              height: context.height * 0.3,
                              width: context.width * 0.8,
                              child: Image.network(
                                image,
                                fit: BoxFit.contain,
                              )),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    ...list.map((option) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: h * 0.07,
                            width: w * 0.8,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: RadioListTile(
                                value: option,
                                groupValue:
                                    controller.quistionList[index].userChoice,
                                activeColor: AppColors.primary,
                                dense: false,
                                onChanged: (value) {
                                  controller.selectChoice(value!);
                                },
                                title: Text(
                                  option,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: AppColors.primary),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
