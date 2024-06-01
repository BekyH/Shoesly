import 'package:shoesly/features/Discover/data/datasource/shoesDatsource.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/domain/repositories/shoesRepository.dart';

class ShoeRepoImpl extends ShoeRepository {
  final ShoeRemoteDataSource shoeRemoteDataSource;
  ShoeRepoImpl({required this.shoeRemoteDataSource});
  @override
  Future<List<Shoe>> getShoes() async {
    return await shoeRemoteDataSource.getShoes();
  }

  @override
  Future<List<Shoe>> getFilteredShoes(String name) async {
    return await shoeRemoteDataSource.getFilteredShoes(name);
  }

  @override
  Future<List<String>> getShoebrands() async {
    return await shoeRemoteDataSource.getShoebrands();
  }
}
