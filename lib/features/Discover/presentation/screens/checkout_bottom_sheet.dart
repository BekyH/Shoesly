import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/presentation/bloc/addCartBloc/add_cart_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/addCartBloc/add_cart_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/addCartBloc/add_cart_state.dart';
import 'package:shoesly/features/Discover/presentation/screens/add_to_cart_bottom_sheet.dart';
import 'package:shoesly/features/Discover/presentation/widgets/loading_button.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final Shoe shoe;
  final String size;
  const CheckoutBottomSheet({Key? key, required this.shoe, required this.size}) : super(key: key);

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
      total = (currentQuantity + 1) * widget.shoe.price;
    });
  }

  void _decrementQuantity() {
    int currentQuantity = int.tryParse(_quantityController.text) ?? 1;
    if (currentQuantity > 1) {
      setState(() {
        _quantityController.text = (currentQuantity - 1).toString();
        total = (currentQuantity - 1) * widget.shoe.price;
      });
    }
  }

  CartItem _createCartItem(double total) {
    return CartItem(
      shoes: widget.shoe.shoeName,
      quantity: int.parse(_quantityController.text),
      price: total.toString(),
      brand: widget.shoe.brand,
      color: widget.shoe.color,
      size: widget.size,
      imageUrl: widget.shoe.imageUrl,
    );
  }

  late double total;
  @override
  void initState() {
    total = widget.shoe.price;
    super.initState();
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
                    const SizedBox(
                      height: 5,
                    ),
                    Text(total.toString())
                  ],
                ),
                BlocListener<AddCartBloc, AddcartState>(
                  listener: ((context, state) {
                    if (state is AddcartSuccess) {
                      Navigator.of(context).pop();
                      showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          isScrollControlled: true,
                          builder: (context) {
                            return AddToCartBottomSheet(
                              quantity: _quantityController.text,
                            );
                          });
                    } else if (state is AddCartFailure) {}
                  }),
                  child: BlocBuilder<AddCartBloc, AddcartState>(
                    builder: (context, state) {
                      if (state is AddcartLoading) {
                        return LoadingButton(
                          title: 'Adding ',
                          color: AppColors.blackColor,
                          onClick: () {},
                          loadingState: true,
                        );
                      } else {
                        return CustomButton(
                          onPressed: () {
                            context.read<AddCartBloc>().add(AddCartItemEvent(
                                cartItem: _createCartItem(total)));
                          },
                          title: 'ADD TO CART',
                          textColor: AppColors.whiteColor,
                          color: AppColors.blackColor,
                        );
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
