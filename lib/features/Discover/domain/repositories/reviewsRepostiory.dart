import 'package:shoesly/features/Discover/data/models/review.dart';

abstract class ReviewsRepository{
  Future<List<Review>> getReviews(String brand);
}