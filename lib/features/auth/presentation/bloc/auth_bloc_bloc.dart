import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/core/entities/models/user.dart';
import 'package:parttime/features/auth/domain/usecase/current_user.dart';
import 'package:parttime/features/auth/domain/usecase/user_sign_up.dart';

import '../../domain/usecase/user_login.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  // final AuthRepository authRepository;
  final UserSignUp _usersignUp;
  final CurrentUser _currentUser;
  final UserLogin _userlogin;
  final AppUserCubit _appUserCubit;

  AuthBlocBloc({
    // required this.authRepository,
    required UserSignUp usersignup,
    required CurrentUser currentUser,
    required UserLogin userlogin,
    required AppUserCubit appuserCubit,
  })  : _usersignUp = usersignup,
        _currentUser = currentUser,
        _userlogin = userlogin,
        _appUserCubit = appuserCubit,
        super(AuthBlocInitial()) {
    on<AuthBlocEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_authSignUp);
    on<AppStarted>(_onAppStarted);
    on<AuthLogin>(_onAuthLoging);
  }

  void _authSignUp(AuthSignUp event, Emitter<AuthBlocState> emit) async {
    final res = await _usersignUp.call(
      USerSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(Authfailure(message: l.message)),
      (r) => emit(AuthSignUpSuccess(message: r)),
    );
  }

  void _onAppStarted(AppStarted event, Emitter<AuthBlocState> emit) async {
    final res = await _currentUser.call(CurrentUserParams());

    res.fold(
      (l) => emit(Authfailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthLoging(AuthLogin event, Emitter<AuthBlocState> emit) async {
    final res = await _userlogin.call(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(Authfailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthBlocState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
