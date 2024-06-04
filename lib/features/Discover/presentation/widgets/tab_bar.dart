import 'package:flutter/material.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';

class CustomTabBar extends StatelessWidget {
  final String title;
  const CustomTabBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: titleTextStyle.copyWith(color: AppColors.tabColor),
      ),
    );
  }
}
