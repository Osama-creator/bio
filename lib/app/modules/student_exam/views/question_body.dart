import 'package:bio/app/modules/student_exam/controllers/student_exam_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';

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
