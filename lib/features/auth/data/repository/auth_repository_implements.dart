import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/network/connection_checker.dart';
import 'package:parttime/features/auth/data/datasourses/auth_remote_data_sorse.dart';
import 'package:parttime/features/auth/data/models/user_model.dart';
import 'package:parttime/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/datasource/auth_ocal_data_source.dart';

class AuthRepositoryImplements implements AuthRepository {
  final AuthRemoteDataSourse authRemoteDataSourse;
  final AuthLcalDataSource authLcalDataSource;
  final Connectionchecker connectionchecker;

  AuthRepositoryImplements({
    required this.authRemoteDataSourse,
    required this.authLcalDataSource,
    required this.connectionchecker,
  });
  @override
  Future<Either<AppFailure, UserModel>> getCurrentUser() async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      final token = authLcalDataSource.getToken();

      if (token == null) {
        return Left(AppFailure("No token found"));
      }
      return await authRemoteDataSourse.getUSerData(token: token);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      return await authRemoteDataSourse.loginWithEmailPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> signUpWithEmailPasswor({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      return await authRemoteDataSourse.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
