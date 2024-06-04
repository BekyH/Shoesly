import 'package:shoesly/features/Discover/data/models/cartItem.dart';
import 'package:shoesly/features/Discover/domain/repositories/cartRepository.dart';

class CartUseCase {
  final CartRepository cartRepository;
  CartUseCase({
    required this.cartRepository
  });

 
  Future<void> addCartItems(CartItem cartItem) async {
    await cartRepository.addCartItems(cartItem);
  }

 
  Future<List<CartItem>> getCartItems() async {
    return await cartRepository.getCartItems();
  }
}
