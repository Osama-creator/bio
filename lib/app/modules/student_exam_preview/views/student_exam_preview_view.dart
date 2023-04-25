import 'package:bio/app/modules/student_exam_preview/views/choice_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../controllers/student_exam_preview_controller.dart';

class StudentExamPreviewView extends GetView<StudentExamPreviewController> {
  const StudentExamPreviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقييم'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'الدرجه',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Text(
              "  ${controller.result} / ${controller.questions.length}",
              style: const TextStyle(fontSize: 25, color: Colors.black),
            ),
            Divider(
              height: 2,
              indent: context.width * 0.1,
              endIndent: context.width * 0.1,
            ),
            const Text(
              'مراجعه الاسئله',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Divider(
              height: 2,
              indent: context.width * 0.1,
              endIndent: context.width * 0.1,
            ),
            ...controller.questions.map((e) => SizedBox(
                  width: context.width * 0.9,
                  child: Card(
                    color: AppColors.white,
                    elevation: 10,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          e.question!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                      ),
                      Column(
                        children: [
                          ChoiceItem(
                            icon: Icons.check_circle_outline_outlined,
                            color: AppColors.primary,
                            title: e.rightAnswer,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          e.userChoice != e.rightAnswer
                              ? ChoiceItem(
                                  icon: Icons.close,
                                  color: Colors.red[900]!,
                                  title: e.userChoice!,
                                )
                              : Container()
                        ],
                      )
                    ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
