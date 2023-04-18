import 'package:bio/app/views/text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: context.height * 0.1,
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
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.isTeacher.value = false;
                    },
                    child: Text(
                      'طالب',
                      style: TextStyle(
                        color: controller.isTeacher.value
                            ? Colors.grey
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      controller.isTeacher.value = true;
                    },
                    child: Text(
                      'مدرس',
                      style: TextStyle(
                        color: controller.isTeacher.value
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
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
                  onPressed: () => controller..login(),
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
