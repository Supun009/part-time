import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/features/menu/domain/entities/faq.dart';
import 'package:parttime/features/menu/domain/entities/terms.dart';

abstract interface class MenuRepository {
  Future<Either<AppFailure, String>> logOutUser();

  Future<Either<AppFailure, FAQ>> getFAQ();

  Future<Either<AppFailure, Terms>> getTerms();

  Future<Either<AppFailure, String>> deleteUserAccount({
    required String reason,
  });

  Future<Either<AppFailure, Map<String, dynamic>>> getPrivacy();

  Future<Either<AppFailure, Map<String, dynamic>>> getContactUs();

  Future<Either<AppFailure, String>> resetPassword({required String email});
}
