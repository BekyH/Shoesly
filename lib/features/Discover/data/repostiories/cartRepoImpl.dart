import 'package:shoesly/features/Discover/data/datasource/cartDatasource.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';
import 'package:shoesly/features/Discover/domain/repositories/cartRepository.dart';

class CartRepoImpl implements CartRepository {
  final CartDataSouceImpl cartDataSouceImpl;
  CartRepoImpl({required this.cartDataSouceImpl});

  @override
  Future<void> addCartItems(CartItem cartItem) async {
    await cartDataSouceImpl.addCartItems(cartItem);
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return await cartDataSouceImpl.getCartItems();
  }
}
