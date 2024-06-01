import 'package:shoesly/features/Discover/data/models/shoe.dart';

abstract class ShoeRepository{
Future<List<Shoe>> getShoes();
}