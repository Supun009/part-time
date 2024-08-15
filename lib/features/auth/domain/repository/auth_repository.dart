import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/features/auth/data/models/user_model.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, String>> signUpWithEmailPasswor({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AppFailure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<AppFailure, UserModel>> getCurrentUser();
}
