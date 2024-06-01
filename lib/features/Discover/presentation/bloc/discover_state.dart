import 'package:shoesly/features/Discover/data/models/shoe.dart';

abstract class ShoeState {}

class ShoeInitial extends ShoeState {}

class ShoeLoading extends ShoeState {}

class ShoeLoaded extends ShoeState {
  final List<Shoe> shoes;
  ShoeLoaded(this.shoes);
}

class ShoeError extends ShoeState {
  final String message;
  ShoeError(this.message);
}
