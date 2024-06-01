import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/domain/repositories/shoesRepository.dart';

class ShoeUsecase {
  final ShoeRepository shoeRepository;
  ShoeUsecase({required this.shoeRepository});
  Future<List<Shoe>> getShoes() async {
    return await shoeRepository.getShoes();
  }
}
