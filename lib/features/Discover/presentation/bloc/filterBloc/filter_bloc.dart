import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/domain/usecase/shoreusecase.dart';
import 'package:shoesly/features/Discover/presentation/bloc/filterBloc/filter_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/filterBloc/filter_state.dart';

class FilterShoesBloc extends Bloc<FilterShoesEvent, FilterShoesState> {
  final ShoeUsecase shoeUsecase;

  FilterShoesBloc({required this.shoeUsecase}) : super(FilterShoesInitial()) {
    on<GetFilteredShoesEvent>((event, emit) async {
      emit(FilterShoesLoading());
      try {
        List<Shoe> filteredShoes = [];
        if (event.brand == "All") {
          filteredShoes = await shoeUsecase.getShoes();
           emit(FilterShoesLoaded(filteredShoes));
        } else {
          final filteredShoes = await shoeUsecase.getFilteredShoes(event.brand);
           emit(FilterShoesLoaded(filteredShoes));
        }

       
      } catch (e) {
        emit(FilterShoesError(e.toString()));
      }
    });
  }
}
