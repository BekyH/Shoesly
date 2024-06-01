import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  final String imageUrl;
  final String brandLogoUrl;
  final String shoeName;
  final double rating;
  final int reviews;
  final double price;

  Shoe({
    required this.imageUrl,
    required this.brandLogoUrl,
    required this.shoeName,
    required this.rating,
    required this.reviews,
    required this.price,
  });

  factory Shoe.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Shoe(
      imageUrl: data['imageUrl'],
      brandLogoUrl: data['brandLogoUrl'],
      shoeName: data['shoeName'],
      rating: data['rating'].toDouble(),
      reviews: data['reviews'],
      price: data['price'].toDouble(),
    );
  }
}
