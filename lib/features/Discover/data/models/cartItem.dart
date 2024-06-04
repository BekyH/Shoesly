import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String shoes;
  final int quantity;
  final String price;
  final String brand;
  final String color;
  final String size;
  final String imageUrl;
  CartItem(
      {required this.shoes,
      required this.quantity,
      required this.price,
      required this.brand,
      required this.color,
      required this.size,
      required this.imageUrl});

  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CartItem(
        shoes: data['shoes'],
        quantity: data['quantity'],
        price: data['price'],
        brand: data['brand'],
        color: data['color'],
        size: data['size'],
        imageUrl: data['imageUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'shoes': shoes,
      'quantity': quantity,
      'price': price,
      'brand': brand,
      'color': color,
      'size': size,
      'imageUrl': imageUrl
    };
  }
}
