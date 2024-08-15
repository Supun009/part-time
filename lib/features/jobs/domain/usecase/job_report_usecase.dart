// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

class ReportJobUsecase implements UseCase<String, ReportJobParams> {
  final JobRemoteRepository jobRemoteRepository;

  ReportJobUsecase({
    required this.jobRemoteRepository,
  });

  @override
  Future<Either<AppFailure, String>> call(ReportJobParams params) async {
    return await jobRemoteRepository.reportJobById(
      userId: params.jobId,
      jobId: params.jobId,
      reason: params.reason,
    );
  }
}

class ReportJobParams {
  final String jobId;
  final String reason;
  final String userId;

  ReportJobParams({
    required this.jobId,
    required this.reason,
    required this.userId,
  });
}
