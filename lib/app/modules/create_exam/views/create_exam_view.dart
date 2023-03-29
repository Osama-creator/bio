import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../../../views/text_field.dart';
import '../controllers/create_exam_controller.dart';

class CreateExamView extends GetView<CreateExamController> {
  const CreateExamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء إمتحان جديد'),
        centerTitle: true,
      ),
      body: GetBuilder<CreateExamController>(
          init: CreateExamController(),
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: context.height * 0.01,
                ),
                MyTextFeild(
                  width: context.width * 0.8,
                  controller: _.examNameController,
                  hintText: 'أدخل إسم الإمتحان',
                  labelText: "إسم الإمتحان",
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.1),
                  child: const Divider(),
                ),
                Center(
                  child: Text(
                    "الأسئله",
                    style: context.textTheme.headline6!.copyWith(
                        color: AppColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.1),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _.questions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: AppColors.white,
                        child: Column(
                          children: [
                            Text(
                              'بيانات السؤال ${index + 1}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: AppColors.primary),
                            ),
                            MyTextFeild(
                              controller: controller.questions[index].questionC,
                              hintText: "السؤال",
                              labelText: "السؤال",
                            ),
                            MyTextFeild(
                              controller: controller.questions[index].questionC,
                              hintText: "الصوره",
                              labelText: "الصوره",
                            ),
                            MyTextFeild(
                              controller:
                                  controller.questions[index].rightAnswerC,
                              hintText: "الإجابه الصحيحه",
                              labelText: "الإجابه الصحيحه",
                            ),
                            MyTextFeild(
                              controller:
                                  controller.questions[index].wrongAnswer1C,
                              hintText: "الإجابه الخاطئه 1",
                              labelText: "الإجابه الخاطئه 1",
                            ),
                            MyTextFeild(
                              controller:
                                  controller.questions[index].wrongAnswer2C,
                              hintText: "الإجابه الخاطئه 2",
                              labelText: "الإجابه الخاطئه 2",
                            ),
                            MyTextFeild(
                              controller:
                                  controller.questions[index].wrongAnswer3C,
                              hintText: "الإجابه الخاطئه 3",
                              labelText: "الإجابه الخاطئه 3",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.1),
                  child: SizedBox(
                    height: context.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () => controller.addQuestion(),
                      child: Text(
                        ' إضافه سؤال',
                        style: context.textTheme.headline6!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: SizedBox(
                //     height: context.height * 0.07,
                //     width: context.width * 0.8,
                //     child: ElevatedButton(
                //       onPressed: _.createExam,
                //       child: Text(
                //         'إنشاء المجموعة',
                //         style: context.textTheme.headline6!.copyWith(
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          }),
    );
  }
}
