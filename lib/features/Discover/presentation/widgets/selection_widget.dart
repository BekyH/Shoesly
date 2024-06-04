import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';
import 'package:shoesly/core/theme/colors.dart';

class SelectionWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const SelectionWidget({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              style: bodySmallTextStyle.copyWith(color: AppColors.tabColor),
            )
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.arrowRightsvg),
        )
      ],
    );
  }
}
