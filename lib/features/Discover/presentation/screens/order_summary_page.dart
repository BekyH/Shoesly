import 'package:flutter/material.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';
import 'package:shoesly/features/Discover/presentation/widgets/order_tile.dart';
import 'package:shoesly/features/Discover/presentation/widgets/payment_tile.dart';
import 'package:shoesly/features/Discover/presentation/widgets/selection_widget.dart';

class OrderSummaryPage extends StatefulWidget {
  static const routename = "/orders_summary_page";
  final List<CartItem> items;
  const OrderSummaryPage({Key? key, required this.items}) : super(key: key);

  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  double total = 0;
  double caculate(List<CartItem> items) {
    for (CartItem item in items) {
      total = total + double.parse(item.price);
    }
    return total;
  }

  @override
  void initState() {
    caculate(widget.items);
    super.initState();
  }

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenHeight * 0.01,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Information",
                      style: bodyMediumTextStyle,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    const SelectionWidget(title: 'Payment', subtitle: 'Credit Card'),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Divider(),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    const SelectionWidget(
                      title: 'Location',
                      subtitle: 'Addis Ababa, Ethiopia',
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      "Order Detail",
                      style: bodyMediumTextStyle,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return OrderTile(cartItem: widget.items[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: screenHeight * 0.015,
                        );
                      },
                      itemCount: widget.items.length,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      'Payment Detail',
                      style: bodyMediumTextStyle,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    PaymentTile(title: "Sub Total", price: total.toString()),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    const PaymentTile(title: "Shipping", price: "50"),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    PaymentTile(title: "Total Order", price: (total + 50).toString()),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.01,
            ),
            color: AppColors.whiteColor,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grand Total',
                      style: bodySmallTextStyle.copyWith(
                          color: AppColors.tabColor),
                    ),
                    Text(
                      '\$17272',
                      style: bodyMediumTextStyle,
                    ),
                  ],
                ),
                const Spacer(),
                CustomButton(
                  title: 'PAYMENT',
                  onPressed: () {},
                  textColor: AppColors.whiteColor,
                  color: AppColors.blackColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
