import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/use_case/base_use_case.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/feature/splash/domain/user_case/change_lang.dart';
import 'package:quotes/feature/splash/domain/user_case/get_saved_lang.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required this.changeLocaleUseCase, required this.getSavedLangUseCase})
      : super(const ChangeLocaleState(Locale(AppStrings.englishCode)));
  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLocaleUseCase;

  String currentLangCode = AppStrings.englishCode;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = value;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLocaleUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = langCode;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  void toEnglish() => _changeLang(AppStrings.englishCode);

  void toArabic() => _changeLang(AppStrings.arabicCode);


}




