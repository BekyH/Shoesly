import 'package:flutter/material.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/presentation/widgets/cart_item.dart';

class CartPage extends StatefulWidget {
  static const routename = "/cart_page";
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> items = [
    CartItem(
        name: 'Jordan 1 Retro High Tie Dye',
        brand: 'Nike',
        color: 'Red Grey',
        size: 40,
        price: 235.00,
        quantity: 1),
    CartItem(
        name: 'Jordan 1 Retro High Tie Dye',
        brand: 'Adidas',
        color: 'Grey',
        size: 42,
        price: 235.00,
        quantity: 1),
    CartItem(
        name: 'Jordan 1 Retro High Tie Dye',
        brand: 'Nike',
        color: 'Green Goblin',
        size: 42,
        price: 235.00,
        quantity: 1),
  ];

  void _incrementQuantity(int index) {
    setState(() {
      items[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  double get _totalPrice {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Carf',
        isBack: true,
      ),
      backgroundColor: AppColors.whiteColor,
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              child:  Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Dismissible(
                    key: Key(item.name + index.toString()),
                    background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: EdgeInsets.symmetric(horizontal: 20.0), child: Icon(Icons.delete, color: Colors.white)),
                    onDismissed: (direction) {
                      _removeItem(index);
                    },
                    child: CartItemWidget(
                      item: item,
                      onIncrement: () => _incrementQuantity(index),
                      onDecrement: () => _decrementQuantity(index),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Grand Total', style: bodySmallTextStyle.copyWith(color: AppColors.tabColor)),
                  Text('\$${_totalPrice.toStringAsFixed(2)}', style: bodyMediumTextStyle),
                ],
              ),
              Spacer(),
            
              CustomButton(
                title: 'CHECK OUT',
                 onPressed: (){}, 
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
