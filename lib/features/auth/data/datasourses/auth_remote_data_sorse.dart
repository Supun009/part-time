import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/datasource/auth_ocal_data_source.dart';
import 'package:parttime/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthRemoteDataSourse {
  Future<Either<AppFailure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AppFailure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<AppFailure, UserModel>> getUSerData({
    required String token,
  });
}

class AuthRemoteDataSorseImpl implements AuthRemoteDataSourse {
  final AuthLcalDataSource authLcalDataSource;
  final String baseUrl;

  AuthRemoteDataSorseImpl({
    required this.baseUrl,
    required this.authLcalDataSource,
  });
  @override
  Future<Either<AppFailure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(Uri.parse('$baseUrl/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: {'Content-Type': 'application/json'});

      final resbody = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 200) {
        return Left(AppFailure(resbody['msg']));
      }
      authLcalDataSource.setToken(resbody['token']);

      return Right(UserModel.fromMap(resbody));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/api/signup'),
        body: jsonEncode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      final resbody = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(resbody['msg']));
      }
      return Right(resbody['msg']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, UserModel>> getUSerData(
      {required String token}) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      ).timeout(const Duration(seconds: 5));

      final resBody = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(resBody['msg']));
      }

      return Right(UserModel.fromMap(resBody));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
