import 'package:bio/app/views/text_field.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "إنشاء حساب جديد",
              style: context.textTheme.headline5!
                  .copyWith(color: AppColors.primary),
            ),
            SizedBox(
              height: context.height * 0.1,
            ),
            MyTextFeild(
              width: context.width * 0.8,
              controller: controller.nameC,
              hintText: 'أسامه عصام ..',
              labelText: "الاسم",
            ),
            MyTextFeild(
              width: context.width * 0.8,
              controller: controller.emailC,
              hintText: 'example@gmail.com',
              labelText: "الايميل",
              keyboardType: TextInputType.emailAddress,
            ),
            MyTextFeild(
              width: context.width * 0.8,
              controller: controller.passwordC,
              hintText: "******",
              labelText: "كلمه السر",
              obscureText: true,
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.09),
                child: Container(
                  height: context.height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(
                      'الصف الدراسي',
                      style: context.textTheme.headline6!
                          .copyWith(fontSize: 14, color: AppColors.primary),
                    ),
                    subtitle: Text(controller.selectedGrade.value?.name ?? ''),
                    onTap: () {
                      controller.showGradeSelectionBottomSheet(context);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.1,
                  vertical: context.height * 0.05),
              child: SizedBox(
                height: context.height * 0.06,
                width: context.width,
                child: ElevatedButton(
                  onPressed: () => controller.signUp(),
                  child: Text(
                    'إنشاء حساب',
                    style: context.textTheme.headline6!.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
