import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoesly/features/Discover/data/models/cartItem.dart';
import 'package:shoesly/features/Discover/data/models/review.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/presentation/screens/Reviews_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/cart_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/discover_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/filter_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/order_summary_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/shoes_details.dart';

class AppRouter {
  MaterialPageRoute? onGeneratedRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case DiscoverPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const DiscoverPage());
      case ShoesDetails.routeName:
        if (args is Shoe) {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (_) => ShoesDetails(shoe: args));
        }
      case FilterPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const FilterPage());
      case ReviewsPage.routeName:
        if (args is String) {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (_) => ReviewsPage(
                    brand: args,
                  ));
        }
      case OrderSummaryPage.routename:
      if(args is List<CartItem>){
         return MaterialPageRoute(
            settings: routeSettings, builder: (_) =>  OrderSummaryPage(items: args,));
      }
       

      case CartPage.routename:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const CartPage());
    }
  }
}
