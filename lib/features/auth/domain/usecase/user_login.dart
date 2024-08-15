import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/auth/domain/repository/auth_repository.dart';

import '../../data/models/user_model.dart';

class UserLogin implements UseCase<UserModel, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<AppFailure, UserModel>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
