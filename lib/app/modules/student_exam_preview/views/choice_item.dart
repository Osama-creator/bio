import 'package:flutter/material.dart';
import '../../../../config/utils/colors.dart';

class ChoiceItem extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;

  const ChoiceItem({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Icon(
                  icon,
                  color: AppColors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
