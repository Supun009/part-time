import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/menu/domain/entities/faq.dart';

import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';

class GetFaqUsecase implements UseCase<FAQ, FAqParams> {
  final MenuRepository menuRepository;

  GetFaqUsecase({
    required this.menuRepository,
  });
  @override
  Future<Either<AppFailure, FAQ>> call(FAqParams params) async {
    return await menuRepository.getFAQ();
  }
}

class FAqParams {}
