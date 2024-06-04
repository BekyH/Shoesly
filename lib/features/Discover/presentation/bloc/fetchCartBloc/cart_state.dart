import 'package:shoesly/features/Discover/data/models/cartItem.dart';

abstract class CartState {}

class CartInitial extends CartState{
  
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartItem> carts;
  CartSuccess({required this.carts});
}

class CartFailure extends CartState {
  final String error;
  CartFailure({
    required this.error
  });
}
