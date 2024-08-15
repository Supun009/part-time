import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';

class GetPrivacyUsecase
    implements UseCase<Map<String, dynamic>, PrivacyParamas> {
  final MenuRepository menuRepository;

  GetPrivacyUsecase({
    required this.menuRepository,
  });
  @override
  Future<Either<AppFailure, Map<String, dynamic>>> call(
      PrivacyParamas params) async {
    return await menuRepository.getPrivacy();
  }
}

class PrivacyParamas {}
