import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/datasource/auth_ocal_data_source.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/features/menu/data/models/faq_model.dart';
import 'package:parttime/features/menu/data/models/terms_model.dart';

abstract interface class MenuDataSource {
  Future<Either<AppFailure, FaqModel>> getFAQ();

  Future<Either<AppFailure, TermsModel>> getTerms();

  Future<Either<AppFailure, String>> deleteUserAccount({
    required String token,
    required String reason,
  });

  Future<Either<AppFailure, Map<String, dynamic>>> getPrivacy();

  Future<Either<AppFailure, Map<String, dynamic>>> getContactUs();

  Future<Either<AppFailure, String>> resetPassword({required String email});
}

class MenuDataSourceImpl implements MenuDataSource {
  final AuthLcalDataSource authLcalDataSource;
  final String baseUrl;

  MenuDataSourceImpl({
    required this.baseUrl,
    required this.authLcalDataSource,
  });
  @override
  Future<Either<AppFailure, FaqModel>> getFAQ() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/api/faq'), headers: {
        'Content-Type': 'application/json',
      });

      var resbody = await jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(resbody['msg']));
      }

      return Right(FaqModel.fromMap(resbody));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, TermsModel>> getTerms() async {
    try {
      final res =
          await http.get(Uri.parse('$baseUrl/api/terms-conditions'), headers: {
        'Content-Type': 'application/json',
      });

      var resbody = await jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(resbody['msg']));
      }

      return Right(TermsModel.fromMap(resbody));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> deleteUserAccount({
    required String token,
    required String reason,
  }) async {
    try {
      final res = await http.delete(
        Uri.parse('$baseUrl/api/delete-account'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: jsonEncode({'reason': reason}),
      );
      final resbody = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(resbody['msg']));
      }
      authLcalDataSource.removeToken();

      return Right(resbody['msg']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getPrivacy() async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/privacy'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final resbody = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(resbody['msg']));
      }
      return Right(resbody);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getContactUs() async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/contactus'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final resbody = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(resbody['msg']));
      }

      return Right(resbody);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> resetPassword(
      {required String email}) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/api/request-reset-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email}),
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
}
