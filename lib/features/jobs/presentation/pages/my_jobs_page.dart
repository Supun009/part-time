import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/jobs/presentation/widgets/job_card.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  String? userEmail;
  bool isMyJobpage = true;

  Future<void> _loadJobs() async {
    final userState = context.read<AppUserCubit>().state as AppUserLoggedIn;
    userEmail = userState.user.email;

    context.read<JobBloc>().add(GetUSerAllJobs(userEmail: userEmail!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My jobs',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: BlocConsumer<JobBloc, JobState>(
                listener: (context, state) {
                  if (state is JobError) {
                    showSnacBar(context, state.error);
                  }
                  if (state is JobUploaded) {
                    print('jobuploaded');
                    _loadJobs();
                  }
                  if (state is JobRemovedById) {
                    showSnacBar(context, state.message);
                    _loadJobs();
                  }
                },
                builder: (context, state) {
                  if (state is Jobloading) {
                    return const Loader();
                  }
                  if (state is UserJobDisplaySuccess) {
                    return ListView.builder(
                      itemCount: state.jobs.length,
                      itemBuilder: (context, index) {
                        final job = state.jobs[index];
                        return JobCard(
                          job: job,
                          isMyjobpage: isMyJobpage,
                        );
                      },
                    );
                  }
                  return const SizedBox(
                    child: Center(child: Text('No my jobs ')),
                  );
                },
              ),
            )
          ],
        ));
  }
}
