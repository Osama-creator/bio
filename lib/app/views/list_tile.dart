import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/utils/colors.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTile;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  const MyListTile(
      {Key? key,
      required this.title,
      required this.subTile,
      this.fontSize,
      this.fontWeight = FontWeight.bold,
      this.fontColor = AppColors.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: context.textTheme.bodyText2!.copyWith(
              color: fontColor, fontSize: fontSize, fontWeight: fontWeight),
        ),
        Text(
          subTile,
          style: context.textTheme.bodyText2!.copyWith(color: fontColor),
        ),
      ],
    );
  }
}
