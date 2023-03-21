import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/utils/colors.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTile;
  const MyListTile({Key? key, required this.title, required this.subTile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style:
              context.textTheme.bodyText2!.copyWith(color: AppColors.primary),
        ),
        Text(
          subTile,
          style:
              context.textTheme.bodyText2!.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}
