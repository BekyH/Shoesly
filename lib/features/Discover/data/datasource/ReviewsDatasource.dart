import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/features/Discover/data/models/review.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';

abstract class ReviewsRemoteDataSource {
  Future<List<Review>> getReviews(String brand);
 
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource  {
  final FirebaseFirestore firestore;

  ReviewsRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<Review>> getReviews(String brand) async {
    final querySnapshot = await firestore.collection('Reviews').where('brand', isEqualTo: brand).get();
    return querySnapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
  }

  

}
