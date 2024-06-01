abstract class FilterShoesEvent {}

class GetFilteredShoesEvent extends FilterShoesEvent {
  final String brand;
  GetFilteredShoesEvent(this.brand);
}
