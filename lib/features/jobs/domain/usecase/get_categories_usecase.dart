import 'package:fpdart/src/either.dart';
import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/jobs/domain/entities/category.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

class GetCategoriesUsecase implements UseCase<List<JobCategory>, NoParamas> {
  final JobRemoteRepository jobRemoteRepository;

  GetCategoriesUsecase({
    required this.jobRemoteRepository,
  });

  @override
  Future<Either<AppFailure, List<JobCategory>>> call(NoParamas params) async {
    return await jobRemoteRepository.getCategoriList();
  }
}

class NoParamas {}
