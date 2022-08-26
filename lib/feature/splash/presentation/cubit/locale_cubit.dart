import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/use_case/base_use_case.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/feature/splash/domain/use_case/change_locale.dart';
import 'package:quotes/feature/splash/domain/use_case/get_saved_lang.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(
      {required this.changeLocaleUseCase, required this.getSavedLangUseCase})
      : super(const ChangeLocale(Locale(AppStrings.englishCode)));
  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLocaleUseCase changeLocaleUseCase;

  String currentLang = AppStrings.englishCode;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(const NoParameters());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      value = currentLang;
      emit(ChangeLocale(Locale(currentLang)));
    });
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLocaleUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLang = langCode;
      emit(ChangeLocale(Locale(currentLang)));
    });
  }

  void toEnglish() => _changeLang(AppStrings.englishCode);

  void toArabic() => _changeLang(AppStrings.arabicCode);
}
