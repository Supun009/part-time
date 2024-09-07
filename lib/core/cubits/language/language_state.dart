part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {
  final Locale locale;
  LanguageInitial({
    required this.locale,
  });
}

final class LanguageChanged extends LanguageState {
  final Locale locale;
  LanguageChanged({
    required this.locale,
  });
}
