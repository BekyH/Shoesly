import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shoesly/features/Discover/data/datasource/ReviewsDatasource.dart';
import 'package:shoesly/features/Discover/data/datasource/cartDatasource.dart';
import 'package:shoesly/features/Discover/data/datasource/shoesDatsource.dart';
import 'package:shoesly/features/Discover/data/repostiories/cartRepoImpl.dart';
import 'package:shoesly/features/Discover/data/repostiories/reviewsRepoImpl.dart';
import 'package:shoesly/features/Discover/data/repostiories/shoesRepoImpl.dart';
import 'package:shoesly/features/Discover/domain/repositories/cartRepository.dart';
import 'package:shoesly/features/Discover/domain/repositories/reviewsRepostiory.dart';
import 'package:shoesly/features/Discover/domain/repositories/shoesRepository.dart';
import 'package:shoesly/features/Discover/domain/usecase/cartUsescase.dart';
import 'package:shoesly/features/Discover/domain/usecase/reviewsUsecase.dart';
import 'package:shoesly/features/Discover/domain/usecase/shoreusecase.dart';
import 'package:shoesly/features/Discover/presentation/bloc/addCartBloc/add_cart_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/brandBloc/brand_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/fetchCartBloc/cart_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/filterBloc/filter_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_bloc.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  // Bloc
  sl.registerFactory<FilterShoesBloc>(() => FilterShoesBloc(shoeUsecase: sl()));
  sl.registerFactory<BrandBloc>(() => BrandBloc(shoeUsecase: sl()));
  sl.registerFactory<ShoeBloc>(() => ShoeBloc(shoeUsecase: sl()));
  sl.registerFactory<ReviewsBloc>(() => ReviewsBloc(reviewsUsecase: sl()));
  sl.registerFactory<AddCartBloc>(() => AddCartBloc(cartUseCase: sl()));
  sl.registerFactory<CartBloc>(() => CartBloc(cartUseCase: sl()));

  // Use cases
  sl.registerLazySingleton<ShoeUsecase>(
      () => ShoeUsecase(shoeRepository: sl()));
  sl.registerLazySingleton<ReviewsUsecase>(
      () => ReviewsUsecase(reviewsRepository: sl()));
  sl.registerLazySingleton<CartUseCase>(
      () => CartUseCase(cartRepository: sl()));

  // Repository
  sl.registerLazySingleton<ShoeRepository>(
      () => ShoeRepoImpl(shoeRemoteDataSource: sl()));
  sl.registerLazySingleton<ReviewsRepository>(
      () => ReviewsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CartRepository>(
      () => CartRepoImpl(cartDataSouceImpl: sl()));

  // Data sources

  sl.registerLazySingleton<CartDataSouceImpl>(() => CartDataSouceImpl(sl()));
  sl.registerLazySingleton<ReviewsRemoteDataSource>(
      () => ReviewsRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ShoeRemoteDataSource>(
      () => ShoeRemoteDataSourceImpl(sl()));

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  sl.registerSingleton(firebaseFirestore);
}
