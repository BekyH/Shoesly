import 'package:flutter/material.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';

class PaymentTile extends StatelessWidget {
  final String title;
  final String price;
  const PaymentTile({Key? key,required this.title,required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,style: bodySmallTextStyle.copyWith(color: AppColors.tabColor),),
        const Spacer(),
        Text("\$$price")
      ],
    );
  }
}
