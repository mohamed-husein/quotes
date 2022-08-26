import 'package:quotes/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LangLocaleDatasource {
  Future<bool> changeLang({required String langCode});

  Future<String> getSaved();
}

class LangLocaleDatasourceImpl extends LangLocaleDatasource {
  final SharedPreferences sharedPreferences;

  LangLocaleDatasourceImpl({required this.sharedPreferences});

  @override
  Future<bool> changeLang({required String langCode}) async =>
      await sharedPreferences.setString(AppStrings.locale, langCode);

  @override
  Future<String> getSaved() async =>
      sharedPreferences.containsKey(AppStrings.locale)
          ? sharedPreferences.getString(AppStrings.locale)!
          : AppStrings.englishCode;
}
