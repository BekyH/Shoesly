abstract class ReviewsEvent {}

class GetReviewsEvent extends ReviewsEvent {
  final String brand;
  GetReviewsEvent(this.brand);
}
