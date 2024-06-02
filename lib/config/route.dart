import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoesly/features/Discover/data/models/shoe.dart';
import 'package:shoesly/features/Discover/presentation/screens/Reviews_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/discover_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/filter_page.dart';
import 'package:shoesly/features/Discover/presentation/screens/shoes_details.dart';

class AppRouter {
  MaterialPageRoute? onGeneratedRoute(RouteSettings routeSettings) {
     final args = routeSettings.arguments;
    switch (routeSettings.name) {
     
      case DiscoverPage.routeName:
      return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const DiscoverPage());
      case ShoesDetails.routeName:
      if(args is Shoe){
         return MaterialPageRoute(
            settings: routeSettings, builder: (_) => ShoesDetails(shoe:args));
      
      }
       case FilterPage.routeName:
      return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const FilterPage());
        case ReviewsPage.routeName:
      return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const ReviewsPage());
       
    }
  }
}
