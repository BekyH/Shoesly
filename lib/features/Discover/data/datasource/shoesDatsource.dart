import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';

abstract class ShoeRemoteDataSource {
  Future<List<Shoe>> getShoes();
  Future<List<String>> getShoebrands();
  Future<List<Shoe>> getFilteredShoes(String name);
}

class ShoeRemoteDataSourceImpl implements ShoeRemoteDataSource {
  final FirebaseFirestore firestore;

  ShoeRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<Shoe>> getShoes() async {
    final querySnapshot = await firestore.collection('shoes').get();
    return querySnapshot.docs.map((doc) => Shoe.fromFirestore(doc)).toList();
  }

  
  @override
  Future<List<String>> getShoebrands() async {
    final querySnapshot = await firestore.collection('brands').get();
    final List<String> tabs = [];
    querySnapshot.docs.forEach((doc) {
      tabs.add(doc.data()['name'] as String);
    });
    return tabs;
  }

@override
  Future<List<Shoe>> getFilteredShoes(String name) async {
    final querySnapshot = await firestore
        .collection('shoes')
        .where('brand', isEqualTo: name)
        .get();
    return querySnapshot.docs.map((doc) => Shoe.fromFirestore(doc)).toList();
  }
}
