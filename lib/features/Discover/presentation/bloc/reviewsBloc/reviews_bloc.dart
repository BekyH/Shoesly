import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/Discover/data/models/review.dart';
import 'package:shoesly/features/Discover/domain/usecase/reviewsUsecase.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewsUsecase reviewsUsecase;

  ReviewsBloc({required this.reviewsUsecase}) : super(ReviewsInitial()) {
    on<GetReviewsEvent>((event, emit) async {
      emit(ReviewsLoading());
      try {
        List<Review> reviews = [];
        // print(event.brand);
        // print(event.rating);
        reviews = await reviewsUsecase.getReviews(event.brand, event.rating);

        emit(ReviewsLoaded(reviews));
      } catch (e) {
        emit(ReviewsError(e.toString()));
      }
    });
  }
}
