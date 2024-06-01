import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/domain/repositories/shoesRepository.dart';

class ShoeUsecase {
  final ShoeRepository shoeRepository;
  ShoeUsecase({required this.shoeRepository});
  Future<List<Shoe>> getShoes() async {
    return await shoeRepository.getShoes();
  }

 Future<List<Shoe>> getFilteredShoes(String name) async {
    return await shoeRepository.getFilteredShoes(name);
  }

   Future<List<String>> getbrands() async {
    return await shoeRepository.getShoebrands();
  }

}
