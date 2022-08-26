import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/media_query_values.dart';
import 'package:quotes/core/widget/error_widget.dart';
import 'package:quotes/feature/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/feature/random_quotes/presentation/widgets/quotes_content.dart';
import 'package:quotes/feature/splash/presentation/cubit/locale_cubit.dart';

class RandomQuotesScreen extends StatelessWidget {
  const RandomQuotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('app_name')!),
        leading: IconButton(
          onPressed: () {
            if(AppLocalizations.of(context)!.isEnLocale)
            {
              BlocProvider.of<LocaleCubit>(context).toArabic();
            }
            else
            {
              BlocProvider.of<LocaleCubit>(context).toEnglish();
            }
          },
          icon: Icon(
            Icons.translate,
            color: AppColors.mainColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<RandomQuotesCubit, RandomQuotesState>(
                builder: (context, state) {
              if (state is RandomQuotesIsLoading) {
                return SizedBox(
                  height: context.height,
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: AppColors.mainColor,
                    ),
                  ),
                );
              } else if (state is RandomQuotesFailed) {
                return ErrorScreen(
                  onPressed: () => BlocProvider.of<RandomQuotesCubit>(context)
                      .getRandomQuotes(),
                );
              } else if (state is RandomQuotesLoaded) {
                return Column(
                  children: [
                    QuoteContent(
                      quote: state.quote,
                    ),
                    InkWell(
                        onTap: () => BlocProvider.of<RandomQuotesCubit>(context)
                            .getRandomQuotes(),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.mainColor),
                          child: const Icon(
                            Icons.refresh,
                            size: 28,
                            color: Colors.white,
                          ),
                        ))
                  ],
                );
              } else {
                return Center(
                  child: SpinKitFadingCircle(
                    color: AppColors.mainColor,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
