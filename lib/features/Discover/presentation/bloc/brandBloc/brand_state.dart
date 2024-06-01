abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<String> tabs;
  BrandLoaded(this.tabs);
}

class BrandError extends BrandState {
  final String message;
  BrandError(this.message);
}