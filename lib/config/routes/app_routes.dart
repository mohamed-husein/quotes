import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/services/service_locator.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/widget/error_widget.dart';
import 'package:quotes/feature/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/feature/random_quotes/presentation/screens/quotes_screen.dart';
import 'package:quotes/feature/splash/presentation/screen/splash_screen.dart';

/* Generate Routing */
class Routes {
  static const String initialRoutes = '/';
  static const String errorScreen = '/errorScreen';
  static const String quoteScreen = '/quoteScreen';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoutes:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case Routes.quoteScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (BuildContext context) =>
                    sl<RandomQuotesCubit>()..getRandomQuotes(),
                child: const RandomQuotesScreen()));
      case Routes.errorScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorScreen());

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}

/*
                         // Named Routing \\
final routes={
  AppRoutes.initialRoutes:(context)=> const RandomQuotesScreen(),
};
*/
