import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/utils/date_parser.dart';
import 'package:shoesly/features/Discover/data/models/review.dart';

class ReviewsCard extends StatelessWidget {
  final Review review;
  ReviewsCard({
    super.key,
    required this.review
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
          child: Row(children: [
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.16,
                  height: screenHeight * 0.08,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl:
                         review.userImageUrl,
                      width: screenWidth * 0.2,
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
                ),
                SizedBox(
                  width: screenWidth * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth*0.5,
                      child: Text(review.userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: bodyTextStyle),
                    ),
                    RatingBarIndicator(
                      itemBuilder: (context, index) {
                        return SvgPicture.asset(
                          Assets.starsvg,
                          colorFilter: const ColorFilter.mode(
                            AppColors.orangeColor,
                            BlendMode.srcIn,
                          ),
                        );
                      },
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                      itemSize: 12,
                      itemCount: 5,
                      rating: 5,
                    ),
                    SizedBox(
                      width: screenWidth*0.55,
                      child: Text(review.comment, style: bodyMediumTextStyle,maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            Text(formatDateTime(DateTime.now()),
                style: bodySmallTextStyle.copyWith(color: AppColors.tabColor)),
          ])),
    );
  }
}
