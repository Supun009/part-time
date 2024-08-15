import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<String, USerSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp({
    required this.authRepository,
  });
  @override
  Future<Either<AppFailure, String>> call(USerSignUpParams params) async {
    return await authRepository.signUpWithEmailPasswor(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class USerSignUpParams {
  final String name;
  final String email;
  final String password;

  USerSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
