// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';

class DeleteUserUsecase implements UseCase<String, NoParams> {
  final MenuRepository menuRepository;

  DeleteUserUsecase({
    required this.menuRepository,
  });
  @override
  Future<Either<AppFailure, String>> call(NoParams params) async {
    return await menuRepository.deleteUserAccount(
      reason: params.reason,
    );
  }
}

class NoParams {
  final String reason;
  NoParams({
    required this.reason,
  });
}
