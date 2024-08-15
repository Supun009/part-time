import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';

class GetContactUsUsecase
    implements UseCase<Map<String, dynamic>, ContactUsParams> {
  final MenuRepository menuRepository;

  GetContactUsUsecase({
    required this.menuRepository,
  });

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> call(
      ContactUsParams params) async {
    return await menuRepository.getContactUs();
  }
}

class ContactUsParams {}
