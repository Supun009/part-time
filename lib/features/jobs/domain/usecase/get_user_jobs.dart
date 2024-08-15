import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/jobs/data/models/job_model.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

class GetUSerJobsUsecase implements UseCase<List<JobModel>, CurrentUserParams> {
  final JobRemoteRepository jobRemoteRepository;

  GetUSerJobsUsecase({
    required this.jobRemoteRepository,
  });
  @override
  Future<Either<AppFailure, List<JobModel>>> call(
      CurrentUserParams params) async {
    return await jobRemoteRepository.getUSerjobs(params.userEmail);
  }
}

class CurrentUserParams {
  final String userEmail;

  CurrentUserParams({
    required this.userEmail,
  });
}
