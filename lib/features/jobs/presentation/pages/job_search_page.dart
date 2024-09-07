import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/jobs/presentation/widgets/job_card.dart';
import 'package:parttime/generated/l10n.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void _searchJobs() async {
    context
        .read<JobBloc>()
        .add(JobSearchEvent(searchTerm: _searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).searchjobs,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onChanged: (value) {
                        // if (value.isEmpty) {
                        //   setState(() {});
                        // }
                      },
                      onSubmitted: (value) {
                        _searchJobs();
                      },
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(20),
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_searchController.text.isEmpty) {
                        null;
                      } else {
                        _searchJobs();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocConsumer<JobBloc, JobState>(
              listener: (context, state) {
                if (state is JobError) {
                  showSnacBar(context, state.error);
                }
              },
              builder: (context, state) {
                if (state is Jobloading) {
                  return const Loader();
                }
                if (state is JobError) {
                  return const SizedBox(
                    child: Center(child: Text('No jobs found ')),
                  );
                }
                if (state is JobSearchCompleted) {
                  return ListView.builder(
                    itemCount: state.jobs.length,
                    itemBuilder: (context, index) {
                      final job = state.jobs[index];
                      return JobCard(job: job);
                    },
                  );
                }
                return const SizedBox(
                  child: Center(child: Text('Search jobs ')),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
