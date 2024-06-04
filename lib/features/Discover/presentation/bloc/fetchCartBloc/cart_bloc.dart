import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/Discover/domain/usecase/cartUsescase.dart';
import 'package:shoesly/features/Discover/presentation/bloc/fetchCartBloc/cart_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/fetchCartBloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCase;
  CartBloc({required this.cartUseCase}) : super(CartInitial()) {
    on<GetCartsEvent>(
      (event, emit) async {
        emit(CartLoading());
        try {
          final res = await cartUseCase.getCartItems();
          emit(CartSuccess(carts: res));
        } catch (e) {
          emit(CartFailure(error: e.toString()));
        }
      },
    );
  }
}
