part of 'job_bloc.dart';

@immutable
sealed class JobState {}

final class JobInitial extends JobState {}

final class JobUploaded extends JobState {
  final String message;

  JobUploaded({required this.message});
}

final class Jobloading extends JobState {}

final class JobDisplaySuccess extends JobState {
  final List<Job> jobs;

  JobDisplaySuccess({
    required this.jobs,
  });
}

final class UserJobDisplaySuccess extends JobState {
  final List<Job> jobs;

  UserJobDisplaySuccess({
    required this.jobs,
  });
}

final class JobError extends JobState {
  final String error;

  JobError({
    required this.error,
  });
}

final class JobRemovedById extends JobState {
  final String message;

  JobRemovedById({
    required this.message,
  });
}

final class JobSearchCompleted extends JobState {
  final List<Job> jobs;

  JobSearchCompleted({
    required this.jobs,
  });
}

final class JobReportCompleted extends JobState {
  final String message;

  JobReportCompleted({
    required this.message,
  });
}

final class JobcateoriesLoaded extends JobState {}
