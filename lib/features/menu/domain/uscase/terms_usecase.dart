import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/menu/domain/entities/terms.dart';
import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';

import '../../../../core/error/app_failure.dart';

class GetTermsUsecase implements UseCase<Terms, TermsParams> {
  final MenuRepository menuRepository;

  GetTermsUsecase({
    required this.menuRepository,
  });
  @override
  Future<Either<AppFailure, Terms>> call(TermsParams params) async {
    return await menuRepository.getTerms();
  }
}

class TermsParams {}
