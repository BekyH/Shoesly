import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String shoes;
  final int quantity;
  final String price;
  CartItem({required this.shoes, required this.quantity, required this.price});

  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CartItem(
        shoes: data['shoes'], quantity: data['quantity'], price: data['price']);
  }

  Map<String, dynamic> toMap() {
    return {
      'shoes': shoes,
      'quantity': quantity,
       'price':price
    };
  }
}
