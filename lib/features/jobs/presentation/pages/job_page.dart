import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/admob/banner_add_widget.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/jobs/presentation/widgets/job_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    _loadJobs();
  }

  Future<void> _loadJobs() async {
    context.read<JobBloc>().add(GetAllJobs());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Feed',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocConsumer<JobBloc, JobState>(
              listener: (context, state) {
                if (state is JobError) {
                  showSnacBar(context, state.error);
                }
                if (state is JobReportCompleted) {
                  _loadJobs();
                }
              },
              builder: (context, state) {
                if (state is Jobloading) {
                  return const Loader();
                }

                if (state is JobDisplaySuccess) {
                  return ListView.builder(
                      itemCount: state.jobs.length + (state.jobs.length ~/ 4),
                      itemBuilder: (context, index) {
                        if ((index + 1) % 5 == 0) {
                          return const BannerAdWidget();
                        } else {
                          final jobIndex = index - (index ~/ 5);
                          final job = state.jobs[jobIndex];
                          return JobCard(job: job);
                        }
                      });
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
