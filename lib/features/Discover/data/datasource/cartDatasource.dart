import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';

abstract class CartDataSource {
  Future<List<CartItem>> getCartItems();

  Future<void> addCartItems(CartItem cartItem);
}

class CartDataSouceImpl implements CartDataSource {
  final FirebaseFirestore firestore;
  CartDataSouceImpl(this.firestore);
  @override
  Future<void> addCartItems(CartItem cartItem) async {
    await firestore.collection('cart').add(cartItem.toMap());
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final querySnapshot = await firestore.collection('cart').get();
    return querySnapshot.docs
        .map((doc) => CartItem.fromFirestore(doc))
        .toList();
  }
}
