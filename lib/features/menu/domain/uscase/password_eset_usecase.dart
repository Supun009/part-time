import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';

class PasswordEsetUsecase implements UseCase<String, PasswordParams> {
  final MenuRepository menuRepository;

  PasswordEsetUsecase({
    required this.menuRepository,
  });
  @override
  Future<Either<AppFailure, String>> call(PasswordParams params) async {
    return await menuRepository.resetPassword(email: params.email);
  }
}

class PasswordParams {
  final String email;

  PasswordParams({
    required this.email,
  });
}
