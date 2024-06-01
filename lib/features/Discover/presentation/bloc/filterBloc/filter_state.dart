import 'package:shoesly/features/Discover/data/models/shoe.dart';

abstract class FilterShoesState {}

class FilterShoesInitial extends FilterShoesState {}

class FilterShoesLoading extends FilterShoesState {}

class FilterShoesLoaded extends FilterShoesState {
  final List<Shoe> shoes;
  FilterShoesLoaded(this.shoes);
}

class FilterShoesError extends FilterShoesState {
  final String message;
  FilterShoesError(this.message);
}
