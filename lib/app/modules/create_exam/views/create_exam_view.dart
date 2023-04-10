import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../../../views/text_field.dart';
import '../controllers/create_exam_controller.dart';

class CreateExamView extends GetView<CreateExamController> {
  const CreateExamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateExamController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('إنشاء إمتحان جديد'),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    controller.createExam();
                  },
                  icon: const Icon(
                    Icons.add_box_rounded,
                  ),
                ),
              ),
              body: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        MyTextFeild(
                          width: context.width * 0.8,
                          controller: controller.examNameController,
                          hintText: 'أدخل إسم الإمتحان',
                          labelText: "إسم الإمتحان",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.1),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.1),
                          child: const Divider(
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.questions.length,
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
                                      controller:
                                          controller.questions[index].questionC,
                                      hintText: "السؤال",
                                      labelText: "السؤال",
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          color: const Color(0x1AD1EC43),
                                          width: context.width,
                                          height: context.height * 0.15,
                                          child: InkWell(
                                            onTap: controller
                                                .questions[index].pickFile,
                                            child: controller.questions[index]
                                                        .image ==
                                                    null
                                                ? const Icon(
                                                    Icons.add,
                                                  )
                                                : Image.file(
                                                    controller.questions[index]
                                                        .image!,
                                                  ),
                                          ),
                                        ),
                                        if (controller.questions[index].image !=
                                            null)
                                          Positioned(
                                            left: 0,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.delete_forever,
                                              ),
                                              onPressed: () {
                                                controller.questions[index]
                                                    .image = null;
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                    MyTextFeild(
                                      controller: controller
                                          .questions[index].rightAnswerC,
                                      hintText: "الإجابه الصحيحه",
                                      labelText: "الإجابه الصحيحه",
                                    ),
                                    MyTextFeild(
                                      controller: controller
                                          .questions[index].wrongAnswer1C,
                                      hintText: "الإجابه الخاطئه 1",
                                      labelText: "الإجابه الخاطئه 1",
                                    ),
                                    MyTextFeild(
                                      controller: controller
                                          .questions[index].wrongAnswer2C,
                                      hintText: "الإجابه الخاطئه 2",
                                      labelText: "الإجابه الخاطئه 2",
                                    ),
                                    MyTextFeild(
                                      controller: controller
                                          .questions[index].wrongAnswer3C,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.1),
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
                      ],
                    ));
        });
  }
}
