import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parttime/core/datasource/auth_ocal_data_source.dart';

part 'is_firsttime_state.dart';

class IsFirsttimeCubit extends Cubit<IsFirsttimeState> {
  final AuthLcalDataSource _authLcalDataSource;
  IsFirsttimeCubit({
    required AuthLcalDataSource authLcalDataSource,
  })  : _authLcalDataSource = authLcalDataSource,
        super(IsFirsttimeInitial()) {
    _loadFirstTime();
  }

  Future<void> _loadFirstTime() async {
    final isFirsttime = _authLcalDataSource.getIsFirstTime();

    if (isFirsttime == null) {
      emit(IsFirsttimeInitial(isFirsttime: true));
    } else {
      emit(IsFirsttime(isFirsttime: false));
    }
  }

  void saveFirstTime() {
    _authLcalDataSource.saveISfirsttime(false);
    emit(IsFirsttime(isFirsttime: false));
  }
}
