import 'package:flutter/material.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/presentation/screens/cart_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/discover_page.dart';

class AddToCartBottomSheet extends StatelessWidget {
  final String quantity;
   const AddToCartBottomSheet({
    Key? key,
    required this.quantity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            const Text(
              'Added to cart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('$quantity Item Total', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomButton(
                  width: screenWidth * 0.4,
                  onPressed: () {
                    Navigator.popAndPushNamed(context, DiscoverPage.routeName);
                  },
                  title: 'BACK EXPLORE',
                  color: AppColors.whiteColor,
                  textColor: AppColors.blackColor,
                ),
                SizedBox(
                  width: screenWidth * 0.1,
                ),
                CustomButton(
                  width: screenWidth * 0.4,
                  onPressed: () {
                    Navigator.pushNamed(context, CartPage.routename);
                  },
                  title: 'TO CART',
                  color: AppColors.blackColor,
                  textColor: AppColors.whiteColor,
                )
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
