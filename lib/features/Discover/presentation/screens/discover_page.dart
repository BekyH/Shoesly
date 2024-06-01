import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/discover_state.dart';
import 'package:shoesly/features/Discover/presentation/bloc/disocover_event.dart';
import 'package:shoesly/features/Discover/presentation/widgets/shoe_card.dart';
import 'package:shoesly/features/Discover/presentation/widgets/tab_bar.dart';

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

  final List<String> _tabs = [
    "All",
    "Nike",
    "Jordan",
    "Addidas",
    "Reebok",
    "Vans"
  ];
  @override
  void initState() {
    context.read<ShoeBloc>().add(GetShoesEvent());
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    super.initState();
  }

  final List<Shoe> shoes = [
    Shoe(
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg', // Replace with actual URLs
        brandLogoUrl:
            'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg',
        shoeName: 'Jordan 1 Retro High Tie Dye',
        rating: 4.5,
        reviews: 1045,
        price: 235.00,
        gender: 'male',
        size: '41',
        color: 'white',
        brand: 'Jordan'),
    // Add more Shoe objects here
    Shoe(
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg', // Replace with actual URLs
        brandLogoUrl:
            'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg',
        shoeName: 'Jordan 1 Retro High Tie Dye',
        rating: 4.5,
        reviews: 1045,
        price: 235.00,
        gender: 'male',
        size: '41',
        color: 'white',
        brand: 'Jordan'),
    Shoe(
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg', // Replace with actual URLs
        brandLogoUrl:
            'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg',
        shoeName: 'Jordan 1 Retro High Tie Dye',
        rating: 4.5,
        reviews: 1045,
        price: 235.00,
        gender: 'male',
        size: '41',
        color: 'white',
        brand: 'Jordan'),
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Discover',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20, top: 10),
              child: InkWell(
                child: SvgPicture.asset(Assets.cartsvg),
              ),
            )
          ],
          // bottom: TabBar(
          //     isScrollable: true,

          //     indicatorPadding: EdgeInsets.zero,
          //     controller: _tabController,
          //     padding: const EdgeInsets.symmetric(horizontal: 15),
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     tabs: const [
          //       CustomTabBar(
          //         title: "All",
          //       ),
          //       CustomTabBar(
          //         title: "Nike",
          //       ),
          //       CustomTabBar(
          //         title: "Jordan",
          //       ),
          //       CustomTabBar(
          //         title: "Addidas",
          //       ),
          //       CustomTabBar(
          //         title: "Reebok",
          //       ),
          //     ]),
        ),
        body:
            // TabBarView(
            //   controller: _tabController,
            //   children: [
            Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
          child: Column(children: [
            Container(
              height: screenHeight * 0.05,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _tabs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        _pageController.jumpToPage(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Center(
                          child: Text(_tabs[index],
                              style: titleTextStyle.copyWith(
                                  color: _selectedIndex == index
                                      ? Colors.black
                                      : AppColors.tabColor)),
                        ),
                      ));
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
                itemCount: _tabs.length,
                itemBuilder: (context, index) {
                  return BlocBuilder<ShoeBloc, ShoeState>(
                      builder: ((context, state) {
                    if (state is ShoeLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ShoeLoaded) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          childAspectRatio: 0.8, // Adjust as needed
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 2,
                        ),
                        itemCount: state.shoes.length,
                        itemBuilder: (context, index) {
                          return ShoeCard(shoe: state.shoes[index]);
                        },
                      );
                    } else if (state is ShoeError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Container();
                    }
                  }));
                },
              ),
            )
          ]),
        )

        //   ],
        // )

        );
  }
}
