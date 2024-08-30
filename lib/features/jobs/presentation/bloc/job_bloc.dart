import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/category/category_cubit.dart';
import 'package:parttime/features/jobs/domain/usecase/edit_job_usecase.dart';
import 'package:parttime/features/jobs/domain/entities/category.dart';
import 'package:parttime/features/jobs/domain/usecase/get_all_jobs_usecase.dart';
import 'package:parttime/features/jobs/domain/usecase/get_categories_usecase.dart';
import 'package:parttime/features/jobs/domain/usecase/get_user_jobs.dart';
import 'package:parttime/features/jobs/domain/usecase/job_report_usecase.dart';
import 'package:parttime/features/jobs/domain/usecase/remove_jobs_by_id.dart';
import 'package:parttime/features/jobs/domain/usecase/search_jobs_usecase.dart';
import 'package:parttime/features/jobs/domain/usecase/upload_job.dart';

import '../../../../core/entities/models/job.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final CategoryCubit _categoryCubit;
  final UploadJobUsecase _uploadJobUsecase;
  final GetAllJobsUsecase _getAllJobsUsecase;
  final GetUSerJobsUsecase _getUSerJobsUsecase;
  final RemoveJobsByIdUsecase _removeJobsByIdUsecase;
  final EditJobUsecase _editJobUsecase;
  final SearchJobsUsecase _searchJobsUsecase;
  final ReportJobUsecase _reportJobUsecase;
  final GetCategoriesUsecase _getCategoriesUsecase;
  JobBloc({
    required UploadJobUsecase uploadJobUsecase,
    required GetAllJobsUsecase getAllJobsUsecase,
    required GetUSerJobsUsecase getUSerJobsUsecase,
    required RemoveJobsByIdUsecase removeJobsByIdUsecase,
    required SearchJobsUsecase searchJobsUsecase,
    required EditJobUsecase editJobUsecase,
    required ReportJobUsecase reportJobUsecase,
    required GetCategoriesUsecase getCategoriesUsecase,
    required CategoryCubit categoryCubit,
  })  : _uploadJobUsecase = uploadJobUsecase,
        _getAllJobsUsecase = getAllJobsUsecase,
        _getUSerJobsUsecase = getUSerJobsUsecase,
        _removeJobsByIdUsecase = removeJobsByIdUsecase,
        _editJobUsecase = editJobUsecase,
        _searchJobsUsecase = searchJobsUsecase,
        _reportJobUsecase = reportJobUsecase,
        _getCategoriesUsecase = getCategoriesUsecase,
        _categoryCubit = categoryCubit,
        super(JobInitial()) {
    on<JobEvent>((event, emit) {
      emit(Jobloading());
    });
    on<JobUpload>(_uploadJobs);
    on<GetAllJobs>(_getAllJobs);
    on<GetUSerAllJobs>(_getUSerAllJobs);
    on<JobRemoveByID>(_removeJobsById);
    on<JobEditEvent>(_editJob);
    on<JobSearchEvent>(_onJobsearch);
    on<JobReportByidevent>(_jobReportByid);
    on<JobcateoriesLoadEvent>(_jobcateoriesLoadEvent);
  }

  void _uploadJobs(JobUpload event, Emitter<JobState> emit) async {
    final res = await _uploadJobUsecase.call(JobParams(
      category: event.category,
      title: event.title,
      description: event.description,
      salary: event.salaryRate,
      location: event.locaion,
      contactfinal: event.contactinfo,
    ));

    res.fold(
      (l) => emit(JobError(error: l.message)),
      (r) => emit(JobUploaded(message: r)),
    );
  }

  void _editJob(JobEditEvent event, Emitter<JobState> emit) async {
    final res = await _editJobUsecase.call(EditJobParams(
      category: event.category,
      jobId: event.jobId,
      title: event.title,
      description: event.description,
      salary: event.salaryRate,
      location: event.locaion,
      contactfinal: event.contactinfo,
    ));

    res.fold(
      (l) => emit(JobError(error: l.message)),
      (r) => emit(JobUploaded(message: r)),
    );
  }

  void _getAllJobs(GetAllJobs event, Emitter<JobState> emit) async {
    final res = await _getAllJobsUsecase.call(Noparams());

    res.fold((l) => emit(JobError(error: l.message)),
        (r) => emit(JobDisplaySuccess(jobs: r)));
  }

  void _getUSerAllJobs(GetUSerAllJobs event, Emitter<JobState> emit) async {
    final res = await _getUSerJobsUsecase
        .call(CurrentUserParams(userEmail: event.userEmail));

    res.fold(
      (l) => emit(JobError(error: l.message)),
      (r) => emit(UserJobDisplaySuccess(jobs: r)),
    );
  }

  void _removeJobsById(JobRemoveByID event, Emitter<JobState> emit) async {
    final res = await _removeJobsByIdUsecase
        .call(RemoveJobsParamas(jobId: event.jobId));

    res.fold(
      (l) => emit(JobError(error: l.message)),
      (r) => emit(JobRemovedById(message: r)),
    );
  }

  void _onJobsearch(JobSearchEvent event, Emitter<JobState> emit) async {
    final res = await _searchJobsUsecase.call(JoSearchParams(
      searchTerm: event.searchTerm,
    ));

    res.fold(
      (l) => emit(JobError(error: l.message)),
      (r) => emit(JobSearchCompleted(jobs: r)),
    );
  }

  void _jobReportByid(JobReportByidevent event, Emitter<JobState> emit) async {
    final res = await _reportJobUsecase.call(ReportJobParams(
        jobId: event.jobId, reason: event.reason, userId: event.userId));

    res.fold(
      (l) => emit(JobError(error: l.message)),
      (r) => emit(JobReportCompleted(message: r)),
    );
  }

  void _jobcateoriesLoadEvent(
      JobcateoriesLoadEvent event, Emitter<JobState> emit) async {
    final res = await _getCategoriesUsecase.call(NoParamas());

    res.fold((l) => emit(JobError(error: l.message)),
        (r) => _loadCategories(categories: r, emit: emit));
  }

  void _loadCategories({
    required List<JobCategory> categories,
    required Emitter<JobState> emit,
  }) {
    _categoryCubit.updatecategoryList(categories);
    emit(JobcateoriesLoaded());
  }
}
