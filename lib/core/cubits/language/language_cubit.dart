import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parttime/core/datasource/auth_ocal_data_source.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final AuthLcalDataSource _authLcalDataSource;
  LanguageCubit({
    required AuthLcalDataSource authLcalDataSource,
  })  : _authLcalDataSource = authLcalDataSource,
        super(LanguageInitial(locale: Locale('en', ''))) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final savedlanguage = _authLcalDataSource.getLanguage();

    if (savedlanguage == 'English') {
      emit(LanguageChanged(locale: Locale('en', '')));
    } else if (savedlanguage == 'Sinhala') {
      emit(LanguageChanged(locale: Locale('si', '')));
    } else {
      emit(LanguageInitial(locale: Locale('en', '')));
    }
  }

  void changeLanguage(Locale locale) {
    print(locale);
    emit(LanguageChanged(locale: locale));
    if (locale == Locale('en', '')) {
      _authLcalDataSource.savelanguage('English');
    } else {
      _authLcalDataSource.savelanguage('Sinhala');
    }
  }
}
