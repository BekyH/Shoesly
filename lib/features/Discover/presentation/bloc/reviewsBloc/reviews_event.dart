abstract class ReviewsEvent {}

class GetReviewsEvent extends ReviewsEvent {
  final String brand;
  final String rating;
  GetReviewsEvent(this.brand,this.rating);
}
