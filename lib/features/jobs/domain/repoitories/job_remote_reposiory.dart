import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/features/jobs/data/models/category_model.dart';
import 'package:parttime/features/jobs/data/models/job_model.dart';

abstract interface class JobRemoteRepository {
  Future<Either<AppFailure, String>> createJob({
    required String title,
    required String category,
    required String description,
    required String salary,
    required String location,
    required String contactInfo,
  });

  Future<Either<AppFailure, List<JobModel>>> getAllJobs();

  Future<Either<AppFailure, List<CategoryModel>>> getCategoriList();

  Future<Either<AppFailure, List<JobModel>>> getUSerjobs(String email);

  Future<Either<AppFailure, String>> removejobsById(String jobId);

  Future<Either<AppFailure, String>> editJobById({
    required String jobId,
    required String title,
    required String category,
    required String description,
    required String salary,
    required String location,
    required String contactInfo,
  });

  Future<Either<AppFailure, List<JobModel>>> searchJobs({
    required String searchTerm,
  });

  Future<Either<AppFailure, String>> reportJobById({
    required String jobId,
    required String userId,
    required String reason,
  });
}
