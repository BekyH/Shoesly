import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/presentation/screens/add_to_cart_bottom_sheet.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final Shoe shoe;
  const CheckoutBottomSheet({Key? key, required this.shoe}) : super(key: key);

  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  void _incrementQuantity() {
    int currentQuantity = int.tryParse(_quantityController.text) ?? 1;
    setState(() {
      _quantityController.text = (currentQuantity + 1).toString();
    });
  }

  void _decrementQuantity() {
    int currentQuantity = int.tryParse(_quantityController.text) ?? 1;
    if (currentQuantity > 1) {
      setState(() {
        _quantityController.text = (currentQuantity - 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.03),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.whiteColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Add to cart',
                  style:
                      bodyMediumTextStyle.copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset(Assets.closesvg),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Quantity',
              style: bodyMediumTextStyle,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(), // Bottom border only
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(Assets.minussvg),
                      onPressed: _decrementQuantity,
                    ),
                    IconButton(
                      icon: SvgPicture.asset(Assets.plussvg),
                      onPressed: _incrementQuantity,
                    ),
                  ],
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter
                    .digitsOnly, // Only allow positive integers
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Price',
                      style: bodySmallTextStyle.copyWith(
                          color: AppColors.tabColor),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.shoe.price.toString())
                  ],
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        isScrollControlled: true,
                        builder: (context) {
                          return const AddToCartBottomSheet();
                        });
                  },
                  title: 'ADD TO CART',
                  textColor: AppColors.whiteColor,
                  color: AppColors.blackColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
