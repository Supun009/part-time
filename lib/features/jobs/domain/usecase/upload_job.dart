import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

class UploadJobUsecase implements UseCase<String, JobParams> {
  final JobRemoteRepository jobRemoteRepository;

  UploadJobUsecase({
    required this.jobRemoteRepository,
  });
  @override
  Future<Either<AppFailure, String>> call(JobParams params) async {
    return await jobRemoteRepository.createJob(
      title: params.title,
      description: params.description,
      salary: params.salary,
      location: params.location,
      contactInfo: params.contactfinal,
    );
  }
}

class JobParams {
  final String title;
  final String description;
  final String salary;
  final String location;
  final String contactfinal;

  JobParams({
    required this.title,
    required this.description,
    required this.salary,
    required this.location,
    required this.contactfinal,
  });
}
