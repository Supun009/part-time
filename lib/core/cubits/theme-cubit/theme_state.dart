part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitstate extends ThemeState {}

final class DarkMode extends ThemeState {
  final ThemeData? theme;

  DarkMode({
    required this.theme,
  });
}

final class LightMode extends ThemeState {
  final ThemeData? theme;

  LightMode({
    required this.theme,
  });
}


