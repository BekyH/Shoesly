import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  final Color textColor;
  final double width;
  final VoidCallback onPressed;

  const CustomIconButton(
      {Key? key,
      required this.icon,
      required this.textColor,
      required this.color,
      required this.title,
       this.width=200,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: bodyMediumTextStyle.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
