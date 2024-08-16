import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:parttime/core/cubits/add_cubit/add_cubit_cubit.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/core/cubits/theme-cubit/theme_cubit.dart';
import 'package:parttime/core/datasource/auth_ocal_data_source.dart';
import 'package:parttime/core/network/connection_checker.dart';
import 'package:parttime/features/auth/data/repository/auth_repository_implements.dart';
import 'package:parttime/features/auth/domain/repository/auth_repository.dart';
import 'package:parttime/features/auth/domain/usecase/current_user.dart';
import 'package:parttime/features/jobs/domain/usecase/job_report_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/delete_user_usecase.dart';
import 'package:parttime/features/auth/domain/usecase/user_login.dart';
import 'package:parttime/features/jobs/domain/usecase/edit_job_usecase.dart';
import 'package:parttime/features/jobs/domain/usecase/get_user_jobs.dart';
import 'package:parttime/features/jobs/domain/usecase/remove_jobs_by_id.dart';
import 'package:parttime/features/jobs/domain/usecase/search_jobs_usecase.dart';
import 'package:parttime/features/menu/data/datasource/menu_data_source.dart';
import 'package:parttime/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:parttime/features/menu/domain/repositories/menu_repository.dart';
import 'package:parttime/features/menu/domain/uscase/get_contact_us_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/get_faq_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/get_privacy_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/password_eset_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/terms_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/user_logout_usecase.dart';
import 'package:parttime/features/auth/domain/usecase/user_sign_up.dart';
import 'package:parttime/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:parttime/features/jobs/data/datasource/job_remote_data_source.dart';
import 'package:parttime/features/jobs/data/repositories/job_remote_repo_impl.dart';
import 'package:parttime/features/jobs/domain/repoitories/job_remote_reposiory.dart';
import 'package:parttime/features/jobs/domain/usecase/get_all_jobs_usecase.dart';
import 'package:parttime/features/jobs/domain/usecase/upload_job.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/menu/presentation/bloc/menu_bloc.dart';
import 'features/auth/data/datasourses/auth_remote_data_sorse.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  final AuthLcalDataSource authLcalDataSourceImpl = AuthLcalDataSourceImpl();
  await authLcalDataSourceImpl.init();
  serviceLocator.registerSingleton<AuthLcalDataSource>(authLcalDataSourceImpl);
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton(
    () => AddCubitCubit(),
  );
  serviceLocator.registerLazySingleton(
    () => ThemeCubit(
      authLcalDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => InternetConnection(),
  );

  serviceLocator.registerFactory<Connectionchecker>(
    () => ConnectionCheckerImpl(
      internetConnection: serviceLocator(),
    ),
  );

  _initAuth();
  _initJob();
  _initMenu();
}

// const String baseUrl = 'http://parttimejobs.ap-south-1.elasticbeanstalk.com';
// const String baseUrl = 'http://192.168.180.61:3000';
// const String baseUrl = 'http://10.0.2.2:3000';
const String baseUrl = 'http://34.47.154.224:80';
// const String baseUrl = 'http://34.93.158.224:80';

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSourse>(
    () => AuthRemoteDataSorseImpl(
      baseUrl: baseUrl,
      authLcalDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImplements(
      authRemoteDataSourse: serviceLocator(),
      authLcalDataSource: serviceLocator(),
      connectionchecker: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserLogin(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => AuthBlocBloc(
      usersignup: serviceLocator(),
      currentUser: serviceLocator(),
      appuserCubit: serviceLocator(),
      userlogin: serviceLocator(),
    ),
  );
}

void _initJob() {
  serviceLocator.registerFactory<JobRemoteDataSource>(
    () => JobRemoteDataSourceImpl(
      baseUrl: baseUrl,
    ),
  );

  serviceLocator.registerFactory<JobRemoteRepository>(
    () => JobRemoteRepositoryImpl(
      authlocalDataSource: serviceLocator(),
      jobremoteDataSource: serviceLocator(),
      connectionchecker: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UploadJobUsecase(
      jobRemoteRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetAllJobsUsecase(
      jobRemoteRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetUSerJobsUsecase(
      jobRemoteRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => RemoveJobsByIdUsecase(
      jobRemoteRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => EditJobUsecase(
      jobRemoteRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SearchJobsUsecase(
      jobRemoteRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => ReportJobUsecase(
      jobRemoteRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => JobBloc(
      uploadJobUsecase: serviceLocator(),
      getAllJobsUsecase: serviceLocator(),
      getUSerJobsUsecase: serviceLocator(),
      removeJobsByIdUsecase: serviceLocator(),
      editJobUsecase: serviceLocator(),
      searchJobsUsecase: serviceLocator(),
      reportJobUsecase: serviceLocator(),
    ),
  );
}

void _initMenu() {
  serviceLocator.registerFactory<MenuDataSource>(
    () => MenuDataSourceImpl(
      baseUrl: baseUrl,
      authLcalDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<MenuRepository>(() => MenuRepositoryImpl(
        authLcalDataSource: serviceLocator(),
        menuDataSource: serviceLocator(),
        connectionchecker: serviceLocator(),
      ));

  serviceLocator.registerFactory(
    () => UserLogOutUsecase(menuRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetFaqUsecase(menuRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetTermsUsecase(menuRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => DeleteUserUsecase(
      menuRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetPrivacyUsecase(
      menuRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => PasswordEsetUsecase(
      menuRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetContactUsUsecase(
      menuRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => MenuBloc(
      userLogOutUsecase: serviceLocator(),
      appuserCubit: serviceLocator(),
      getFaqUsecase: serviceLocator(),
      getTermsUsecase: serviceLocator(),
      deleteUserUsecase: serviceLocator(),
      getPrivacyUsecase: serviceLocator(),
      passwordEsetUsecase: serviceLocator(),
      contactUsUsecase: serviceLocator(),
    ),
  );
}
