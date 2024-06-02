import 'package:shoesly/features/Discover/data/models/review.dart';
import 'package:shoesly/features/Discover/domain/repositories/reviewsRepostiory.dart';

class ReviewsUsecase {
  final ReviewsRepository reviewsRepository;
  ReviewsUsecase({required this.reviewsRepository});

  Future<List<Review>> getReviews(String brand) async {
    return await reviewsRepository.getReviews(brand);
  }
}
