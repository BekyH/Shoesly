import 'package:flutter/material.dart';
import 'package:shoesly/core/theme/colors.dart';

class SizeContainer extends StatelessWidget {
  final String title;
  final bool selected;
  const SizeContainer({Key? key, required this.title, required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.all(8),
        height: screenHeight * 0.04,
        width: screenWidth * 0.09,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected? AppColors.blackColor:AppColors.whiteColor,
            border: Border.all(width: 1.5, color: AppColors.tabColor)),
        child: Text(title,style: TextStyle(color: selected?AppColors.whiteColor:AppColors.blackColor),));
  }
}
