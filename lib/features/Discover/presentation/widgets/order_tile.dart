import 'package:flutter/material.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';

class OrderTile extends StatelessWidget {
  final CartItem cartItem;
  const OrderTile({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartItem.shoes,
          style: bodyMediumTextStyle,
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Text(
              cartItem.brand,
              style: bodySmallTextStyle.copyWith(color: AppColors.tabColor),
            ),
            Text(
              cartItem.color,
              style: bodySmallTextStyle.copyWith(color: AppColors.tabColor),
            ),
            Text(
              "Qty ${cartItem.quantity.toString()}",
              style: bodySmallTextStyle.copyWith(color: AppColors.tabColor),
            ),
            const Spacer(),
            Text("\$${cartItem.price}",style: bodyMediumTextStyle,)
          ],
        )
      ],
    );
  }
}
