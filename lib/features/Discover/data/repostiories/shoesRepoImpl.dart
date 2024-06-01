import 'package:shoesly/features/Discover/data/datasource/shoesDatsource.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/domain/repositories/shoesRepository.dart';

class ShoeRepoImpl extends ShoeRepository {
  final ShoeRemoteDataSource shoeRemoteDataSource;
  ShoeRepoImpl({
    required this.shoeRemoteDataSource
  });
  @override
  Future<List<Shoe>> getShoes() async {
    return await shoeRemoteDataSource.getShoes();
  }
}
