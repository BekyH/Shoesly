import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';

import 'package:shoesly/core/theme/colors.dart';

import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_state.dart';
import 'package:shoesly/features/Discover/presentation/widgets/item_review_card.dart';

class ReviewsPage extends StatefulWidget {
  final String brand;
  static const routeName = "/reviews_page";


  const ReviewsPage({Key? key,required this.brand}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final Map<String, String> tabs = {
      "All": "all",
      "5 stars": "5",
      "4 stars": "4",
      "3 stars": "3",
      "2 stars": "2",
      "1 star": "1"
    };

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: 'Review',
        isBack: true,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.05,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  String displayText = tabs.keys.elementAt(index);
                  String dbValue = tabs.values.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      context.read<ReviewsBloc>().add(GetReviewsEvent(widget.brand,dbValue));
                      _pageController.jumpToPage(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Center(
                        child: Text(displayText,
                            style: titleTextStyle.copyWith(
                                        color: _selectedIndex == index
                                            ? Colors.black
                                            : AppColors.tabColor)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return BlocBuilder<ReviewsBloc, ReviewsState>(
                    builder: (context, state) {
                      if (state is ReviewsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ReviewsLoaded) {
                        if (state.reviews.isEmpty) {
                          return const Center(
                            child: Text("No reviews with this rating"),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.reviews.length,
                          itemBuilder: (context, index) {
                            final review = state.reviews[index];
                            return ReviewsCard(review: review);
                          },
                        );
                      } else if (state is ReviewsError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
