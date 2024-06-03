import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/core/widgets/custom_button.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/reviewsBloc/reviews_state.dart';
import 'package:shoesly/features/Discover/presentation/screens/Reviews_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/cart_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/checkout_bottom_sheet.dart';
import 'package:shoesly/features/Discover/presentation/widgets/custom_image_shoe.dart';
import 'package:shoesly/features/Discover/presentation/widgets/item_review_card.dart';
import 'package:shoesly/features/Discover/presentation/widgets/size_container.dart';

class ShoesDetails extends StatefulWidget {
  static const routeName = "/shoesdetails_page";
  final Shoe shoe;
  const ShoesDetails({Key? key, required this.shoe}) : super(key: key);

  @override
  _ShoesDetailsState createState() => _ShoesDetailsState();
}

class _ShoesDetailsState extends State<ShoesDetails> {
  int _selectedColorIndex = 0;

  void _handleColorSelection(int index) {
    setState(() {
      _selectedColorIndex = index;
    });
  }

  @override
  void initState() {
    context.read<ReviewsBloc>().add(GetReviewsEvent(widget.shoe.brand, 'all'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        isBack: true,
        onTap: () {
          Navigator.of(context).pop();
        },
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, CartPage.routename);
              },
              child: SvgPicture.asset(Assets.cartsvg),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, vertical: screenHeight * 0.001),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShoeWidget(
                shoeImageUrl: widget.shoe.imageUrl,
                colorOptions: [Colors.black, Colors.white, Colors.blue],
                selectedColorIndex: _selectedColorIndex,
                onColorSelected: _handleColorSelection,
              ),
              SizedBox(height: 16),
              Text(widget.shoe.shoeName, style: bodyMediumTextStyle),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star_half, color: Colors.yellow),
                  SizedBox(width: 8),
                  Text(
                    "${widget.shoe.rating} (${widget.shoe.reviews} Reviews)",
                    style:
                        bodySmallTextStyle.copyWith(color: AppColors.tabColor),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text("Size", style: bodyMediumTextStyle),
              SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizeContainer(title: "38"),
                  SizeContainer(title: "39"),
                  SizeContainer(title: "40"),
                  SizeContainer(title: "41"),
                  SizeContainer(title: "42")
                ],
              ),
              const SizedBox(height: 16),
              Text("Description", style: bodyMediumTextStyle),
              const SizedBox(height: 8),
              Text(
                widget.shoe.description,
                style: bodyTextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Text("Reviews", style: bodyMediumTextStyle),
              const SizedBox(height: 8),
              BlocBuilder<ReviewsBloc, ReviewsState>(
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
                    int len = state.reviews.length;
                    if (len > 3) {
                      len = 3;
                    }
                    return SingleChildScrollView(
                        child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: len,
                      itemBuilder: (context, index) {
                        final review = state.reviews[index];
                        return ReviewsCard(review: review);
                      },
                    ));
                  } else if (state is ReviewsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CustomButton(
                    title: 'SEE ALL REVIEW',
                    onPressed: () {
                      context
                          .read<ReviewsBloc>()
                          .add(GetReviewsEvent(widget.shoe.brand, 'all'));
                      Navigator.pushNamed(context, ReviewsPage.routeName,
                          arguments: widget.shoe.brand);
                    },
                    color: AppColors.whiteColor,
                    textColor: AppColors.blackColor),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price",
                    style:
                        bodySmallTextStyle.copyWith(color: AppColors.tabColor),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text("\$${widget.shoe.price}", style: bodyMediumTextStyle),
                ],
              ),
              CustomButton(
                title: 'ADD TO CART',
                color: AppColors.blackColor,
                textColor: AppColors.whiteColor,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.white,
                      builder: (context) {
                        return CheckoutBottomSheet();
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
