

import 'package:shoesly/features/Discover/data/models/cartItem.dart';

abstract class AddCartEvent {}

class AddCartItemEvent extends AddCartEvent {
  final CartItem cartItem;
  AddCartItemEvent({
    required this.cartItem
  });
}
