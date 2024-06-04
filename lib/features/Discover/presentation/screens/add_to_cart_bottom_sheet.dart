import 'package:flutter/material.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/presentation/screens/cart_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/discover_page.dart';

class AddToCartBottomSheet extends StatelessWidget {
 
  const AddToCartBottomSheet({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Colors.black,
            ),
            SizedBox(height: 16),
            Text(
              'Added to cart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('1 Item Total', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
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
