part of 'job_bloc.dart';

@immutable
sealed class JobEvent {}

final class JobUpload extends JobEvent {
  final String title;
  final String description;
  final String salaryRate;
  final String locaion;
  final String contactinfo;

  JobUpload({
    required this.title,
    required this.description,
    required this.salaryRate,
    required this.locaion,
    required this.contactinfo,
  });
}

final class JobEditEvent extends JobEvent {
  final String jobId;
  final String title;
  final String description;
  final String salaryRate;
  final String locaion;
  final String contactinfo;

  JobEditEvent({
    required this.jobId,
    required this.title,
    required this.description,
    required this.salaryRate,
    required this.locaion,
    required this.contactinfo,
  });
}

final class GetAllJobs extends JobEvent {}

final class GetUSerAllJobs extends JobEvent {
  final String userEmail;

  GetUSerAllJobs({
    required this.userEmail,
  });
}

final class JobRemoveByID extends JobEvent {
  final String jobId;

  JobRemoveByID({
    required this.jobId,
  });
}

final class JobSearchEvent extends JobEvent {
  final String searchTerm;

  JobSearchEvent({
    required this.searchTerm,
  });
}

final class JobReportByidevent extends JobEvent {
  final String jobId;
  final String reason;
  final String userId;

  JobReportByidevent({
    required this.reason,
    required this.userId,
    required this.jobId,
  });
}
