
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/Discover/domain/usecase/shoreusecase.dart';

import 'brand_event.dart';
import 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final ShoeUsecase shoeUsecase;

  BrandBloc({required this.shoeUsecase}) : super(BrandInitial()) {
    on<GetBrandsEvent>((event, emit) async {
      emit(BrandLoading());
      try {
        final brands = await shoeUsecase.getbrands();
        emit(BrandLoaded(brands));
      } catch (e) {
        emit(BrandError(e.toString()));
      }
    });
  }
}
