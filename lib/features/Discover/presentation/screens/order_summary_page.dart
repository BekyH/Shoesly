import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';
import 'package:shoesly/features/Discover/presentation/widgets/order_tile.dart';
import 'package:shoesly/features/Discover/presentation/widgets/payment_tile.dart';
import 'package:shoesly/features/Discover/presentation/widgets/selection_widget.dart';

class OrderSummaryPage extends StatelessWidget {
  static const routename = "/orders_summary_page";
  final List<CartItem> items;
  const OrderSummaryPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(
          title: 'Order Summary',
          centerTitle: true,
          isBack: true,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Information",
                  style: bodyMediumTextStyle,
                ),
                SizedBox(
                  width: 10,
                ),
                SelectionWidget(title: 'Payment', subtitle: 'Credit Card'),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                SelectionWidget(
                    title: 'Location', subtitle: 'Addis Ababa,Ethiopia'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Order Detail",
                  style: bodyMediumTextStyle,
                ),
               SingleChildScrollView(
                
                child:  ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderTile(cartItem: items[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: items.length),),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Payment Detail',
                  style: bodyMediumTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                PaymentTile(title: "Sub Total", price: "705"),
                SizedBox(
                  height: 10,
                ),
                PaymentTile(title: "shipping", price: "50"),
                SizedBox(
                  height: 10,
                ),
                PaymentTile(title: "Total Order", price: "734"),
                Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Grand Total',
                    style:
                        bodySmallTextStyle.copyWith(color: AppColors.tabColor)),
                Text('\$17272', style: bodyMediumTextStyle),
              ],
            ),
            const Spacer(),
            CustomButton(
              title: 'PAYMENT',
              onPressed: () {},
              textColor: AppColors.whiteColor,
              color: AppColors.blackColor,
            )
          ],
        )
              ],
              
            ),
          ),
        ),
        );
  }
}
