import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';

class ShoeCard extends StatelessWidget {
  final Shoe shoe;

  const ShoeCard({
    Key? key,
    required this.shoe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        color: AppColors.tabColor,
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(padding: EdgeInsets.all(10),
                  child: CachedNetworkImage(
                      imageUrl:
                         shoe.brandLogoUrl,
                     
                      height: screenHeight * 0.03,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                          width: screenWidth*0.1,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                      ),
                    ),
                  
                  )
                ),
                SizedBox(height: screenWidth * 0.02),
                Center(
                  child: CachedNetworkImage(
                      imageUrl:
                         shoe.imageUrl,
                     
                      height: screenHeight * 0.1,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          shoe.shoeName,
          style: bodyTextStyle
        ),
        SizedBox(height: screenWidth * 0.01),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow[700],
              size: screenWidth * 0.05,
            ),
            SizedBox(width: screenWidth * 0.01),
            Text(
              shoe.rating.toString(),
              style: titleTextStyle
            ),
            SizedBox(width: screenWidth * 0.01),
            Text(
              '(${shoe.reviews} Reviews)',
              style: bodyTextStyle.copyWith(color: Colors.grey)
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          '\$${shoe.price}',
          style: titleTextStyle
        ),
      ],
    );
  }
}
