import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/network/connection_checker.dart';
import 'package:parttime/features/jobs/data/datasource/job_remote_data_source.dart';
import 'package:parttime/features/jobs/data/models/job_model.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

import '../../../../core/datasource/auth_ocal_data_source.dart';

class JobRemoteRepositoryImpl implements JobRemoteRepository {
  final JobRemoteDataSource jobremoteDataSource;
  final AuthLcalDataSource authlocalDataSource;
  final Connectionchecker connectionchecker;
  JobRemoteRepositoryImpl({
    required this.jobremoteDataSource,
    required this.authlocalDataSource,
    required this.connectionchecker,
  });
  @override
  Future<Either<AppFailure, String>> createJob({
    required String title,
    required String description,
    required String salary,
    required String location,
    required String contactInfo,
  }) async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      final token = authlocalDataSource.getToken();
      if (token == null) {
        return Left(AppFailure("No token found"));
      }
      return await jobremoteDataSource.uploadJob(
        token: token,
        title: title,
        description: description,
        salary: salary,
        location: location,
        contactInfo: contactInfo,
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<JobModel>>> getAllJobs() async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      final token = authlocalDataSource.getToken();
      if (token == null) {
        return Left(AppFailure("No token found"));
      }
      return await jobremoteDataSource.getAlljobs(token);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<JobModel>>> getUSerjobs(
      String userEmail) async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      return await jobremoteDataSource.getUSerjobs(userEmail);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> removejobsById(
    String jobId,
  ) async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      final token = authlocalDataSource.getToken();
      if (token == null) {
        return Left(AppFailure("No token found"));
      }
      return await jobremoteDataSource.removejobsById(
        jobId: jobId,
        token: token,
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> editJobById(
      {required String jobId,
      required String title,
      required String description,
      required String salary,
      required String location,
      required String contactInfo}) async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      final token = authlocalDataSource.getToken();
      if (token == null) {
        return Left(AppFailure("No token found"));
      }
      return await jobremoteDataSource.editJobById(
        jobId: jobId,
        token: token,
        title: title,
        location: location,
        description: description,
        contactInfo: contactInfo,
        salary: salary,
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<JobModel>>> searchJobs({
    required String searchTerm,
  }) async {
    try {
      if (!await (connectionchecker.isconnected)) {
        return Left(AppFailure('No internet connection'));
      }
      final token = authlocalDataSource.getToken();
      if (token == null) {
        return Left(AppFailure("No token found"));
      }
      return await jobremoteDataSource.searchJobs(
        searchTerm: searchTerm,
        token: token,
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> reportJobById({
    required String jobId,
    required String userId,
    required String reason,
  }) async {
    try {
      if (!await connectionchecker.isconnected) {
        return Left(AppFailure('No internet connection'));
      }

      return await jobremoteDataSource.reportJob(
        jobId: jobId,
        reason: reason,
        userId: userId,
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
