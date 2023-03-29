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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.2),
                  child: SizedBox(
                    height: context.height * 0.05,
                    child: ElevatedButton(
                      onPressed: _.createExam,
                      child: Text(
                        ' إضافه سؤال',
                        style: context.textTheme.headline6!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _.questions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_.questions[index].question!),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: context.height * 0.07,
                    width: context.width * 0.8,
                    child: ElevatedButton(
                      onPressed: _.createExam,
                      child: Text(
                        'إنشاء المجموعة',
                        style: context.textTheme.headline6!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
