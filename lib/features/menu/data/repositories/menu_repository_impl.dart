import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/datasource/auth_ocal_data_source.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/network/connection_checker.dart';
import 'package:parttime/features/menu/data/datasource/menu_data_source.dart';
import 'package:parttime/features/menu/data/models/faq_model.dart';
import 'package:parttime/features/menu/domain/entities/terms.dart';
import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  final AuthLcalDataSource authLcalDataSource;
  final MenuDataSource menuDataSource;
  final Connectionchecker connectionchecker;

  MenuRepositoryImpl({
    required this.authLcalDataSource,
    required this.menuDataSource,
    required this.connectionchecker,
  });
  @override
  Future<Either<AppFailure, String>> logOutUser() async {
    try {
      authLcalDataSource.removeToken();
      return const Right("User logout");
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, FaqModel>> getFAQ() async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      return menuDataSource.getFAQ();
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Terms>> getTerms() async {
    return await menuDataSource.getTerms();
  }

  @override
  Future<Either<AppFailure, String>> deleteUserAccount({
    required String reason,
  }) async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      final token = authLcalDataSource.getToken();

      if (token == null) {
        return Left(AppFailure("No token found"));
      }
      return await menuDataSource.deleteUserAccount(
        reason: reason,
        token: token,
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getPrivacy() async {
    try {
      return await menuDataSource.getPrivacy();
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> resetPassword({
    required String email,
  }) async {
    return await menuDataSource.resetPassword(email: email);
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getContactUs() async {
    try {
      return await menuDataSource.getContactUs();
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
