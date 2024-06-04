import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/Discover/domain/usecase/cartUsescase.dart';
import 'package:shoesly/features/Discover/presentation/bloc/addCartBloc/add_cart_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/addCartBloc/add_cart_state.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddcartState> {
  final CartUseCase cartUseCase;
  AddCartBloc({required this.cartUseCase}) : super(AddCartInitial()) {
    on<AddCartItemEvent>(
      (event, emit) async {
        emit(AddcartLoading());
        try {
          await cartUseCase.addCartItems(event.cartItem);
          emit(AddcartSuccess(message: "Added to cart Successfully"));
        } catch (e) {
          emit(AddCartFailure(error: e.toString()));
        }
      },
    );
  }
}
