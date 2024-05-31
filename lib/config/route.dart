import 'package:flutter/material.dart';
import 'package:shoesly/features/Discover/presentation/screens/discover_page.dart';

class AppRouter {
  MaterialPageRoute? onGeneratedRoute(RouteSettings routeSettings) {
    // final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case DiscoverPage.routeName:
      return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const DiscoverPage());
    }
  }
}
