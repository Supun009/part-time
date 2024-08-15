// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/datasource/auth_ocal_data_source.dart';
import 'package:parttime/core/theme/theme.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final AuthLcalDataSource _authLcalDataSource;
  ThemeCubit({
    required AuthLcalDataSource authLcalDataSource,
  })  : _authLcalDataSource = authLcalDataSource,
        super(LightMode(theme: AppTheme.lightThemeMode)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = _authLcalDataSource.getTheme();

    if (savedTheme == 'dark') {
      emit(DarkMode(theme: AppTheme.darkThemeMode));
    } else {
      emit(LightMode(theme: AppTheme.lightThemeMode));
    }
  }

  void toggleTheme() {
    if (state is LightMode) {
      emit(DarkMode(theme: AppTheme.darkThemeMode));
      _authLcalDataSource.savetheme('dark');
    } else {
      emit(LightMode(theme: AppTheme.lightThemeMode));
      _authLcalDataSource.savetheme('light');
    }
  }
}
