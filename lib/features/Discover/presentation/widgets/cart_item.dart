import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  CartItemWidget({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.shoes,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('${item.brand} . ${item.color} . ${item.size}',
                    style: bodyMediumTextStyle.copyWith(
                        color: AppColors.tabColor)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('\$${item.price}', style: bodyMediumTextStyle),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: null,
                    ),
                    Text('${item.quantity}', style: TextStyle(fontSize: 16)),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: null,
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
