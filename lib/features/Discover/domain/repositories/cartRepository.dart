
import 'package:shoesly/features/Discover/data/models/cartItem.dart';

abstract class CartRepository{
      Future<List<CartItem>> getCartItems();

  Future<void> addCartItems(CartItem cartItem);
}