import 'package:flutter/material.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color color;
  final double width;
  final VoidCallback onPressed;
  final Color textColor;

  CustomButton({
    Key? key,
    this.icon,
    required this.title,
    this.color = Colors.blue,
    this.width = 200.0,
    required this.onPressed,
    required this.textColor
  }) : super(key: key);

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
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20.0),
              SizedBox(width: 8.0),
            ],
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
