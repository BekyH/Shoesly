import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/Discover/domain/usecase/shoreusecase.dart';
import 'package:shoesly/features/Discover/presentation/bloc/discover_state.dart';
import 'package:shoesly/features/Discover/presentation/bloc/disocover_event.dart';

class ShoeBloc extends Bloc<ShoeEvent, ShoeState> {
  final ShoeUsecase shoeUsecase;

  ShoeBloc({required this.shoeUsecase}) : super(ShoeInitial()) {
    on<GetShoesEvent>((event, emit) async {
      emit(ShoeLoading());
      try {
        final shoes = await shoeUsecase.getShoes();
        emit(ShoeLoaded(shoes));
      } catch (e) {
        emit(ShoeError(e.toString()));
      }
    });
  }
}