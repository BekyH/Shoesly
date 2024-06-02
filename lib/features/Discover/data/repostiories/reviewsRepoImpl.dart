import 'package:shoesly/features/Discover/data/datasource/ReviewsDatasource.dart';
import 'package:shoesly/features/Discover/data/models/review.dart';
import 'package:shoesly/features/Discover/domain/repositories/reviewsRepostiory.dart';

class ReviewsRepoImpl implements ReviewsRepository {
  final ReviewsRemoteDataSource remoteDataSource;
  ReviewsRepoImpl({required this.remoteDataSource});
  @override
  Future<List<Review>> getReviews(String brand) async {
    return await remoteDataSource.getReviews(brand);
  }
}
