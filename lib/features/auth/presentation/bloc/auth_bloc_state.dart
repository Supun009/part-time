part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthSuccess extends AuthBlocState {
  final User user;

  AuthSuccess({
    required this.user,
  });
}

final class Authfailure extends AuthBlocState {
  final String message;

  Authfailure({
    required this.message,
  });
}

final class AuthSignUpSuccess extends AuthBlocState {
  final String message;

  AuthSignUpSuccess({
    required this.message,
  });
}
