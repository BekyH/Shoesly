import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/config/route.dart';
import 'package:shoesly/dp_injection/dp_injection.dart';
import 'package:shoesly/features/Discover/presentation/bloc/brandBloc/brand_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/Discover/presentation/bloc/filterBloc/filter_bloc.dart';

import 'package:shoesly/features/Discover/presentation/screens/discover_page.dart';
import 'package:shoesly/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  await serviceLocatorInit();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (_)=>sl<ShoeBloc>()),
       BlocProvider(create: (_)=>sl<BrandBloc>()),
        BlocProvider(create: (_)=>sl<FilterShoesBloc>())
    ], 
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: appRouter.onGeneratedRoute,
      initialRoute: DiscoverPage.routeName,
      debugShowCheckedModeBanner: false,
    ));
  }
}
