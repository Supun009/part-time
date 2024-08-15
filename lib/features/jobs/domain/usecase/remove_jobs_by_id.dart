import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

class RemoveJobsByIdUsecase implements UseCase<String, RemoveJobsParamas> {
  final JobRemoteRepository jobRemoteRepository;

  RemoveJobsByIdUsecase({
    required this.jobRemoteRepository,
  });
  @override
  Future<Either<AppFailure, String>> call(RemoveJobsParamas params) async {
    return await jobRemoteRepository.removejobsById(params.jobId);
  }
}

class RemoveJobsParamas {
  final String jobId;

  RemoveJobsParamas({
    required this.jobId,
  });
}
