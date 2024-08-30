// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:parttime/core/error/app_failure.dart';
import 'package:parttime/core/usecase/usecase.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';

class EditJobUsecase implements UseCase<String, EditJobParams> {
  final JobRemoteRepository jobRemoteRepository;

  EditJobUsecase({
    required this.jobRemoteRepository,
  });
  @override
  Future<Either<AppFailure, String>> call(EditJobParams params) async {
    return await jobRemoteRepository.editJobById(
      category: params.category,
      jobId: params.jobId,
      title: params.title,
      description: params.description,
      salary: params.salary,
      location: params.location,
      contactInfo: params.contactfinal,
    );
  }
}

class EditJobParams {
  final String jobId;
  final String title;
  final String category;
  final String description;
  final String salary;
  final String location;
  final String contactfinal;

  EditJobParams({
    required this.jobId,
    required this.title,
    required this.category,
    required this.description,
    required this.salary,
    required this.location,
    required this.contactfinal,
  });
}
