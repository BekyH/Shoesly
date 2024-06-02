import 'package:flutter/material.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';

class ReviewsPage extends StatelessWidget {
  static const routeName = "/reviews_page";
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: 'Review',
        isBack: true,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
