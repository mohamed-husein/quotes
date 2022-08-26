import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations_setup.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/config/theme_data/light_theme.dart';
import 'package:quotes/core/services/service_locator.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/feature/splash/presentation/cubit/locale_cubit.dart';

class RandomQuotes extends StatelessWidget {
  const RandomQuotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<LocaleCubit>()..getSavedLang(),)
    ],
      child: BlocBuilder<LocaleCubit,LocaleState>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: lightTheme(context),
            onGenerateRoute:AppRoutes.onGenerateRoute,
            locale: state.locale,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
            AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
            AppLocalizationsSetup.localizationsDelegates,

          );
        },
      ),
    );
  }
}
