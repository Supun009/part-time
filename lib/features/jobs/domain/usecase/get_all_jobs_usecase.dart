import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/jobs/data/models/job_model.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

class GetAllJobsUsecase implements UseCase<List<JobModel>, Noparams> {
  final JobRemoteRepository jobRemoteRepository;

  GetAllJobsUsecase({
    required this.jobRemoteRepository,
  });
  @override
  Future<Either<AppFailure, List<JobModel>>> call(Noparams params) async {
    return await jobRemoteRepository.getAllJobs();
  }
}

class Noparams {}
