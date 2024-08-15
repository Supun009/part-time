import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/jobs/data/models/job_model.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

class SearchJobsUsecase implements UseCase<List<JobModel>, JoSearchParams> {
  final JobRemoteRepository jobRemoteRepository;

  SearchJobsUsecase({
    required this.jobRemoteRepository,
  });
  @override
  Future<Either<AppFailure, List<JobModel>>> call(JoSearchParams params) async {
    return await jobRemoteRepository.searchJobs(searchTerm: params.searchTerm);
  }
}

class JoSearchParams {
  final String searchTerm;

  JoSearchParams({
    required this.searchTerm,
  });
}
