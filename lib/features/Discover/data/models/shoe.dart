import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  final String imageUrl;
  final String brandLogoUrl;
  final String shoeName;
  final double rating;
  final double reviews;
  final double price;
  final String color;
  final String size;
  final String gender;
  final String brand;
  final String description;

  Shoe(
      {required this.imageUrl,
      required this.brandLogoUrl,
      required this.shoeName,
      required this.rating,
      required this.reviews,
      required this.price,
      required this.color,
      required this.size,
      required this.gender,
      required this.brand,
      required this.description
      });

  factory Shoe.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Shoe(
        imageUrl: data['imageUrl'],
        brandLogoUrl: data['brandLogoUrl'],
        shoeName: data['shoeName'],
        rating: double.parse(data['rating']),
        reviews: double.parse(data['reviews']),
        price: double.parse(data['price']),
        gender: data['gender'],
        size: data['size'],
        color: data['color'],
        brand: data['brand'],
        description: data['description']
        );
  }
}
