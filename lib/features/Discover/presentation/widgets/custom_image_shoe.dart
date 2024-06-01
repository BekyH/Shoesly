import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CustomShoeWidget extends StatelessWidget {
  final String shoeImageUrl;
  final List<Color> colorOptions;
  final int selectedColorIndex;
  final Function(int) onColorSelected;

  CustomShoeWidget({
    required this.shoeImageUrl,
    required this.colorOptions,
    required this.selectedColorIndex,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Shoe Image
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: shoeImageUrl,
                     height: screenheight * 0.18,
                          width: double.infinity,
                          fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                ),
        ),
        SizedBox(height: 10),
        // Image Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 0 ? Colors.black : Colors.grey,
              ),
            );
          }),
        ),
        SizedBox(height: 10),
        // Color Options
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(colorOptions.length, (index) {
            return GestureDetector(
              onTap: () => onColorSelected(index),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorOptions[index],
                  border: index == selectedColorIndex
                      ? Border.all(color: Colors.black, width: 2)
                      : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

