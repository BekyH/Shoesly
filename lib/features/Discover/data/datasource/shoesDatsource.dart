import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';


abstract class ShoeRemoteDataSource {
  Future<List<Shoe>> getShoes();
}

class ShoeRemoteDataSourceImpl implements ShoeRemoteDataSource {
  final FirebaseFirestore firestore;

  ShoeRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<Shoe>> getShoes() async {
    final querySnapshot = await firestore.collection('shoes').get();
    return querySnapshot.docs.map((doc) => Shoe.fromFirestore(doc)).toList();
  }
}