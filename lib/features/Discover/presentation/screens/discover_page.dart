import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/core/widgets/custom_icon_button.dart';
import 'package:shoesly/features/Discover/presentation/bloc/brandBloc/brand_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/brandBloc/brand_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/brandBloc/brand_state.dart';
import 'package:shoesly/features/Discover/presentation/bloc/filterBloc/filter_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/filterBloc/filter_event.dart';
import 'package:shoesly/features/Discover/presentation/bloc/filterBloc/filter_state.dart';
import 'package:shoesly/features/Discover/presentation/screens/cart_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/filter_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/shoes_details.dart';

import 'package:shoesly/features/Discover/presentation/widgets/shoe_card.dart';

class DiscoverPage extends StatefulWidget {
  static const routeName = "/discover_page";
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<BrandBloc>().add(GetBrandsEvent());
    context.read<FilterShoesBloc>().add(GetFilteredShoesEvent("All"));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Discover',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20, top: 10),
              child: InkWell(
                child: SvgPicture.asset(Assets.cartsvg),
                onTap: () {
                   Navigator.pushNamed(context, CartPage.routename);
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
          child: Column(
            children: [
              BlocBuilder<BrandBloc, BrandState>(
                builder: (context, state) {
                  if (state is BrandLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BrandLoaded) {
                    final tabs = ["All", ...state.tabs];
                    return Container(
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
                                  .read<FilterShoesBloc>()
                                  .add(GetFilteredShoesEvent(tabs[index]));
                              _pageController.jumpToPage(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Center(
                                child: Text(tabs[index],
                                    style: titleTextStyle.copyWith(
                                        color: _selectedIndex == index
                                            ? Colors.black
                                            : AppColors.tabColor)),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is BrandError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                     final tabs = ["All", ...(context.read<BrandBloc>().state as BrandLoaded).tabs];
                  context.read<FilterShoesBloc>().add(GetFilteredShoesEvent(tabs[index]));
                  },
                  itemBuilder: (context, index) {
                    return BlocBuilder<FilterShoesBloc, FilterShoesState>(
                      builder: (context, state) {
                        if (state is FilterShoesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FilterShoesLoaded) {
                          if (state.shoes.isEmpty) {
                            return const Center(
                              child: Text("No Shoeses with this brand"),
                            );
                          }
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, 
                              childAspectRatio: 0.8, 
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 2,
                            ),
                            itemCount: state.shoes.length,
                            itemBuilder: (context, index) {
                              final shoes = state.shoes[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ShoesDetails.routeName,
                                      arguments: shoes);
                                },
                                child: ShoeCard(shoe: shoes),
                              );
                            },
                          );
                        } else if (state is FilterShoesError) {
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
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: CustomIconButton(
              title: 'FILTER',
              color: Colors.black,
              icon:Assets.filtersvg,
              onPressed: () {
                Navigator.pushNamed(context, FilterPage.routeName);
              },
              textColor: AppColors.whiteColor),
        ));
  }
}
