part of 'locale_cubit.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

class ChangeLocale extends LocaleState {
  const ChangeLocale(Locale selectedLocale) : super(selectedLocale);
}
