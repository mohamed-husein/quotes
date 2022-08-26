import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptor.dart';
import 'package:quotes/core/api/dio_consumer.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/feature/random_quotes/data/datasource/local_datasource.dart';
import 'package:quotes/feature/random_quotes/data/datasource/remote_datasource.dart';
import 'package:quotes/feature/random_quotes/data/repository/quote_repository.dart';
import 'package:quotes/feature/random_quotes/domain/repository/base_quote_repository.dart';
import 'package:quotes/feature/random_quotes/domain/use_cases/get_random_quote.dart';
import 'package:quotes/feature/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/feature/splash/data/datasource/lang_locale_datasource.dart';
import 'package:quotes/feature/splash/data/repository/lang_repository_impl.dart';
import 'package:quotes/feature/splash/domain/repository/lang_repository.dart';
import 'package:quotes/feature/splash/domain/use_case/change_locale.dart';
import 'package:quotes/feature/splash/domain/use_case/get_saved_lang.dart';
import 'package:quotes/feature/splash/presentation/cubit/locale_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // Features
    // Bloc
    sl.registerFactory(() => RandomQuotesCubit(getRandomQuote: sl()));
    sl.registerFactory<LocaleCubit>(
            () => LocaleCubit(getSavedLangUseCase: sl(), changeLocaleUseCase: sl()));
    // UseCase
    sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));
    sl.registerLazySingleton<GetSavedLangUseCase>(
            () => GetSavedLangUseCase(baseLangRepository: sl()));
    sl.registerLazySingleton<ChangeLocaleUseCase>(
            () => ChangeLocaleUseCase(baseLangRepository: sl()));
    //Repository
    sl.registerLazySingleton<BaseQuoteRepository>(
        () => QuoteRepository(sl(), sl(), sl()));
    sl.registerLazySingleton<BaseLangRepository>(
            () => LangRepositoryImpl(langLocaleDatasource: sl()));
    //Remote Datasource
    sl.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource(apiConsumer:sl() ));
    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client:sl() ));
    sl.registerLazySingleton<LangLocaleDatasource>(
            () => LangLocaleDatasourceImpl(sharedPreferences: sl()));
    sl.registerLazySingleton(() => Dio());
    ////Local Datasource
    sl.registerLazySingleton<BaseLocalDataSource>(
        () => LocalDataSource(sharedPreferences: sl()));
    // Core
    //NetworkInfo
    sl.registerLazySingleton<NetworkInfo>(
        () => NetworkChecker(connectionChecker: sl()));
    sl.registerLazySingleton(() => InternetConnectionChecker());
    // External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    sl.registerLazySingleton(() => AppInterceptor());
    sl.registerLazySingleton(
      () => LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }
}
