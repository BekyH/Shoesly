import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';
import 'package:shoesly/features/Discover/presentation/bloc/fetchCartBloc/cart_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/fetchCartBloc/cart_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/fetchCartBloc/cart_state.dart';
import 'package:shoesly/features/Discover/presentation/widgets/cart_item.dart';

class CartPage extends StatefulWidget {
  static const routename = "/cart_page";
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(GetCartsEvent());
    super.initState();
  }

  double total = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
        isBack: true,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
        child: Column(
          children: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CartSuccess) {
                  List<CartItem> items = state.carts;
                  return Expanded(
                      child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                     
                      return CartItemWidget(
                        item: item,
                      );
                    },
                  ));
                } else if (state is CartFailure) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.01),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Grand Total',
                            style: bodySmallTextStyle.copyWith(
                                color: AppColors.tabColor)),
                        Text('$total', style: bodyMediumTextStyle),
                      ],
                    ),
                    Spacer(),
                    CustomButton(
                      title: 'CHECK OUT',
                      onPressed: () {},
                      textColor: AppColors.whiteColor,
                      color: AppColors.blackColor,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
