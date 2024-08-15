import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';

final class UserLogOutUsecase implements UseCase<String, UserLogOutParams> {
  final MenuRepository menuRepository;

  UserLogOutUsecase({
    required this.menuRepository,
  });
  @override
  Future<Either<AppFailure, String>> call(UserLogOutParams params) async {
    return await menuRepository.logOutUser();
  }
}

final class UserLogOutParams {}
