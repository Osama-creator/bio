import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const MyTextFeild({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.orange,
        cursorHeight: 23,
        style: context.textTheme.bodyText1!
            .copyWith(color: AppColors.black, fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle: context.textTheme.bodyText2!
              .copyWith(color: AppColors.grey, fontSize: 15),
          labelStyle: context.textTheme.bodyText2!
              .copyWith(color: AppColors.primary, fontSize: 15),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
