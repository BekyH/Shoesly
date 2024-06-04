abstract class AddcartState {}

class AddCartInitial extends AddcartState{
  
}

class AddcartLoading extends AddcartState {}

class AddcartSuccess extends AddcartState {
  final String message;
  AddcartSuccess({required this.message});
}

class AddCartFailure extends AddcartState {
  final String error;
  AddCartFailure({
    required this.error
  });
}
