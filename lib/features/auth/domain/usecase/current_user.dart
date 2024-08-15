import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/entities/models/user.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, CurrentUserParams> {
  final AuthRepository authRepository;

  CurrentUser({
    required this.authRepository,
  });
  @override
  Future<Either<AppFailure, User>> call(CurrentUserParams params) async {
    return await authRepository.getCurrentUser();
  }
}

class CurrentUserParams {}
