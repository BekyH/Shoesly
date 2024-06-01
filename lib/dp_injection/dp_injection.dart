import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shoesly/features/Discover/data/datasource/shoesDatsource.dart';
import 'package:shoesly/features/Discover/data/repostiories/shoesRepoImpl.dart';
import 'package:shoesly/features/Discover/domain/repositories/shoesRepository.dart';
import 'package:shoesly/features/Discover/domain/usecase/shoreusecase.dart';
import 'package:shoesly/features/Discover/presentation/bloc/discover_bloc.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  // Bloc
  sl.registerFactory<ShoeBloc>(() => ShoeBloc(shoeUsecase:  sl()));

  // Use cases
  sl.registerLazySingleton<ShoeUsecase>(() => ShoeUsecase(shoeRepository: sl()));

  // Repository
  sl.registerLazySingleton<ShoeRepository>(() => ShoeRepoImpl(shoeRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ShoeRemoteDataSource>(() => ShoeRemoteDataSourceImpl(FirebaseFirestore.instance));
}