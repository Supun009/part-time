import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:http/http.dart' as http;
import 'package:parttime/features/jobs/data/models/category_model.dart';
import 'package:parttime/features/jobs/data/models/job_model.dart';

abstract interface class JobRemoteDataSource {
  Future<Either<AppFailure, String>> uploadJob({
    required String token,
    required String title,
    required String category,
    required String description,
    required String salary,
    required String location,
    required String contactInfo,
  });

  Future<Either<AppFailure, String>> editJobById({
    required String jobId,
    required String token,
    required String title,
    required String category,
    required String description,
    required String salary,
    required String location,
    required String contactInfo,
  });

  Future<Either<AppFailure, List<JobModel>>> getAlljobs(String token);

  Future<Either<AppFailure, List<CategoryModel>>> getCategoriList();

  Future<Either<AppFailure, List<JobModel>>> getUSerjobs(String userEmail);

  Future<Either<AppFailure, String>> removejobsById({
    required String jobId,
    required String token,
  });

  Future<Either<AppFailure, List<JobModel>>> searchJobs(
      {required String searchTerm, required String token});

  Future<Either<AppFailure, String>> reportJob({
    required String userId,
    required String jobId,
    required String reason,
  });
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final String baseUrl;

  JobRemoteDataSourceImpl({
    required this.baseUrl,
  });

  @override
  Future<Either<AppFailure, String>> removejobsById({
    required String jobId,
    required String token,
  }) async {
    try {
      final res = await http.delete(
        Uri.parse('$baseUrl/api/jobs-delete?id=$jobId'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
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
  Future<Either<AppFailure, String>> uploadJob(
      {required String token,
      required String title,
      required String category,
      required String description,
      required String salary,
      required String location,
      required String contactInfo}) async {
    try {
      final res = await http.post(Uri.parse('$baseUrl/api/uploadjob'),
          headers: {
            'Content-Type': 'application/json',
            'x-auth-token': token,
          },
          body: jsonEncode({
            'category': category,
            'title': title,
            'description': description,
            'salary': salary,
            'location': location,
            'contactInfo': contactInfo,
          }));

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
  Future<Either<AppFailure, List<JobModel>>> getAlljobs(String token) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/alljob'),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": token,
        },
      );

      if (res.statusCode != 200) {
        final resbody = jsonDecode(res.body) as Map<String, dynamic>;
        return Left(AppFailure(resbody['msg']));
      }
      var jobs = await jsonDecode(res.body) as List;
      List<JobModel> jobList = [];
      for (final job in jobs) {
        jobList.add(JobModel.fromMap(job));
      }

      return Right(jobList);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<JobModel>>> getUSerjobs(
      String userEmail) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/user-jobs?userEmail=$userEmail'),
        headers: {"Content-Type": "application/json"},
      );

      if (res.statusCode != 200) {
        final resbody = jsonDecode(res.body) as Map<String, dynamic>;

        return Left(AppFailure(resbody['msg']));
      }
      var jobs = await jsonDecode(res.body) as List;
      List<JobModel> jobList = [];
      for (final job in jobs) {
        jobList.add(JobModel.fromMap(job));
      }
      return Right(jobList);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> editJobById({
    required String jobId,
    required String token,
    required String title,
    required String category,
    required String description,
    required String salary,
    required String location,
    required String contactInfo,
  }) async {
    try {
      final res = await http.put(Uri.parse('$baseUrl/api/editjob?id=$jobId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token,
          },
          body: jsonEncode(<String, String>{
            'category': category,
            'title': title,
            'description': description,
            'salary': salary,
            'location': location,
            'contactInfo': contactInfo,
          }));
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
  Future<Either<AppFailure, List<JobModel>>> searchJobs(
      {required String searchTerm, required String token}) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/searchjobs?q=$searchTerm'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );

      if (res.statusCode != 200) {
        final resbody = jsonDecode(res.body) as Map<String, dynamic>;
        return Left(AppFailure(resbody['msg']));
      }

      var jobs = await jsonDecode(res.body) as List;
      List<JobModel> jobList = [];
      for (final job in jobs) {
        jobList.add(JobModel.fromMap(job));
      }
      return Right(jobList);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> reportJob({
    required String userId,
    required String jobId,
    required String reason,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/api/report-job'), // Adjust the endpoint as needed
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'jobId': jobId,
          'reason': reason,
          'userId': userId,
        }),
      );

      final resbody = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 201) {
        return Left(AppFailure(resbody['msg']));
      }

      return Right(resbody['msg']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<CategoryModel>>> getCategoriList() async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/categories'),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode != 200) {
        final resBody = jsonDecode(res.body) as Map<String, dynamic>;
        return Left(AppFailure(resBody['msg']));
      }

      var categories = await jsonDecode(res.body) as List;

      List<CategoryModel> categoriList = [];

      for (final category in categories) {
        categoriList.add(CategoryModel.fromMap(category));
      }

      return Right(categoriList);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
