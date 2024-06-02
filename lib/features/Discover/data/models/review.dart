import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String userName;
  final String userImageUrl;
  final String rating;
  final String comment;
  final String brand;
  Review(
      {required this.userName,
      required this.userImageUrl,
      required this.rating,
      required this.comment,
      required this.brand});

  factory Review.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Review(
        userName: data['userName'],
        userImageUrl: data['userImageUrl'],
        rating: data['rating'],
        comment: data['comment'],
        brand: data['brand']);
  }
}
