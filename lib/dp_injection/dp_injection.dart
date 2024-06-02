import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shoesly/features/Discover/data/datasource/ReviewsDatasource.dart';
import 'package:shoesly/features/Discover/data/datasource/shoesDatsource.dart';
import 'package:shoesly/features/Discover/data/repostiories/reviewsRepoImpl.dart';
import 'package:shoesly/features/Discover/data/repostiories/shoesRepoImpl.dart';
import 'package:shoesly/features/Discover/domain/repositories/reviewsRepostiory.dart';
import 'package:shoesly/features/Discover/domain/repositories/shoesRepository.dart';
import 'package:shoesly/features/Discover/domain/usecase/reviewsUsecase.dart';
import 'package:shoesly/features/Discover/domain/usecase/shoreusecase.dart';
import 'package:shoesly/features/Discover/presentation/bloc/brandBloc/brand_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/filterBloc/filter_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_bloc.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  // Bloc
  sl.registerFactory<FilterShoesBloc>(() => FilterShoesBloc(shoeUsecase: sl()));
  sl.registerFactory<BrandBloc>(() => BrandBloc(shoeUsecase: sl()));
  sl.registerFactory<ShoeBloc>(() => ShoeBloc(shoeUsecase: sl()));
  sl.registerFactory<ReviewsBloc>(() => ReviewsBloc(reviewsUsecase: sl()));

  // Use cases
  sl.registerLazySingleton<ShoeUsecase>(
      () => ShoeUsecase(shoeRepository: sl()));
  sl.registerLazySingleton<ReviewsUsecase>(
      () => ReviewsUsecase(reviewsRepository: sl()));

  // Repository
  sl.registerLazySingleton<ShoeRepository>(
      () => ShoeRepoImpl(shoeRemoteDataSource: sl()));
  sl.registerLazySingleton<ReviewsRepository>(
      () => ReviewsRepoImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ReviewsRemoteDataSource>(
      () => ReviewsRemoteDataSourceImpl(FirebaseFirestore.instance));
  sl.registerLazySingleton<ShoeRemoteDataSource>(
      () => ShoeRemoteDataSourceImpl(FirebaseFirestore.instance));
}
