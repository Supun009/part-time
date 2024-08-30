import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/admob/banner_add_widget.dart';
import 'package:parttime/core/cubits/category/category_cubit.dart';
import 'package:parttime/core/entities/models/job.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/theme/app_pallete.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/jobs/domain/entities/category.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/jobs/presentation/widgets/category_clip.dart';
import 'package:parttime/features/jobs/presentation/widgets/job_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();

    _loadJobs();
  }

  Future<void> _loadJobs() async {
    context.read<JobBloc>().add(GetAllJobs());
  }

  void addCategories(String categoryname) {
    if (selectedCategories.contains(categoryname)) {
      selectedCategories.remove(categoryname);
    } else if (selectedCategories.isEmpty) {
      selectedCategories.add(categoryname);
    } else {
      selectedCategories.clear();
      selectedCategories.add(categoryname);
    }
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
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryInitial) {
                return SizedBox();
              }
              if (state is CategoriesState) {
                return SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categoryList.length,
                          itemBuilder: (context, index) {
                            final JobCategory category =
                                state.categoryList[index];

                            return CategoryClip(
                              isCategoryValid: true,
                              color: selectedCategories.contains(category.name)
                                  ? WidgetStatePropertyAll(
                                      AppPallete.accentColor)
                                  : WidgetStatePropertyAll(Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor),
                              onTap: () {
                                addCategories(category.name);
                                setState(() {});
                              },
                              categoryName: category.name,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
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
                  if (selectedCategories.isNotEmpty) {
                    List<Job> filterdList = state.jobs
                        .where((job) => job.category == selectedCategories[0])
                        .toList();
                    return ListView.builder(
                        itemCount:
                            filterdList.length + (filterdList.length ~/ 4),
                        itemBuilder: (context, index) {
                          if ((index + 1) % 5 == 0) {
                            return const BannerAdWidget();
                          } else {
                            final jobIndex = index - (index ~/ 5);
                            final job = state.jobs[jobIndex];
                            return JobCard(job: job);
                          }
                        });
                  } else {
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
