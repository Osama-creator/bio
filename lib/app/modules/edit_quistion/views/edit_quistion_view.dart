import 'package:bio/app/views/text_field.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_quistion_controller.dart';

class EditQuistionView extends GetView<EditQuistionController> {
  const EditQuistionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل السؤال'),
        centerTitle: true,
      ),
      body: GetBuilder<EditQuistionController>(
          init: controller,
          builder: (_) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  Card(
                    color: AppColors.white,
                    child: Column(
                      children: [
                        MyTextFeild(
                          controller: controller.questionController,
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
                                onTap: controller.pickFile,
                                child: controller.image == null && controller.imageString.isEmpty
                                    ? const Icon(
                                        Icons.add,
                                      )
                                    : controller.imageString.isNotEmpty
                                        ? SizedBox(
                                            height: context.height * 0.2,
                                            width: context.width * 0.8,
                                            child: Image.network(
                                              controller.imageString,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : Image.file(
                                            controller.image!,
                                          ),
                              ),
                            ),
                            if (controller.image != null)
                              Positioned(
                                left: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete_forever,
                                  ),
                                  onPressed: () {
                                    controller.image = null;
                                    controller.update();
                                  },
                                ),
                              ),
                          ],
                        ),
                        MyTextFeild(
                          controller: controller.rightAnswerController,
                          hintText: "الإجابه الصحيحه",
                          labelText: "الإجابه الصحيحه",
                        ),
                        MyTextFeild(
                          controller: controller.wrongAnswer1Controller,
                          hintText: "الإجابه الخاطئه 1",
                          labelText: "الإجابه الخاطئه 1",
                        ),
                        MyTextFeild(
                          controller: controller.wrongAnswer2Controller,
                          hintText: "الإجابه الخاطئه 2",
                          labelText: "الإجابه الخاطئه 2",
                        ),
                        MyTextFeild(
                          controller: controller.wrongAnswer3Controller,
                          hintText: "الإجابه الخاطئه 3",
                          labelText: "الإجابه الخاطئه 3",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.width * 0.1, vertical: 10),
                    child: SizedBox(
                      height: context.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateQuestionInFirebase();
                        },
                        child: controller.isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                'حفظ',
                                style: context.textTheme.titleLarge!.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
