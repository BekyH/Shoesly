
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoesly/core/theme/colors.dart';

import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_state.dart';
import 'package:shoesly/features/Discover/presentation/widgets/item_review_card.dart';


class ReviewsPage extends StatefulWidget {
  static const routeName = "/reviews_page";

  const ReviewsPage({Key? key}) : super(key: key);

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

    final tabs = ["All", "5 stars", "4 stars", "3 stars", "2 stars", "1 star"];

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
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        print(tabs[index]);
                      });
                      context
                          .read<ReviewsBloc>()
                          .add(GetReviewsEvent(tabs[index]));
                      _pageController.jumpToPage(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Center(
                        child: Text(tabs[index],
                            style: TextStyle(
                                fontSize: 16, // Adjust as needed
                                fontWeight: FontWeight.bold, // Adjust as needed
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ReviewsLoaded) {
                        if (state.reviews.isEmpty) {
                          return Center(
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

