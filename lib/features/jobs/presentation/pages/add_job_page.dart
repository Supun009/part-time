import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/category/category_cubit.dart';
import 'package:parttime/core/entities/models/job.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/theme/app_pallete.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/jobs/domain/entities/category.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/jobs/presentation/widgets/category_clip.dart';
import 'package:parttime/features/jobs/presentation/widgets/job_editor.dart';
import 'package:parttime/generated/l10n.dart';

class JobPostPage extends StatefulWidget {
  final Job? job;
  final bool? isMyjobpage;
  const JobPostPage({
    super.key,
    this.job,
    this.isMyjobpage,
  });

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  final TextEditingController jobdescription = TextEditingController();
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController salarycontroller = TextEditingController();
  final TextEditingController locationecontroller = TextEditingController();
  final TextEditingController contactinfocontroller = TextEditingController();
  List<String> selectedCategories = [];
  bool isCategoryValid = true;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      titlecontroller.text = widget.job!.title;
      jobdescription.text = widget.job!.description;
      salarycontroller.text = widget.job!.salaryRate;
      locationecontroller.text = widget.job!.location;
      contactinfocontroller.text = widget.job!.contactInfo;
    }
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
    titlecontroller.dispose();
    jobdescription.dispose();
    salarycontroller.dispose();
    locationecontroller.dispose();
    contactinfocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isMyjobpage != true) {
                  if (formkey.currentState!.validate()) {
                    if (selectedCategories.isEmpty) {
                      setState(() {
                        isCategoryValid = false;
                      });
                    } else {
                      context.read<JobBloc>().add(
                            JobUpload(
                                category: selectedCategories[0],
                                title: titlecontroller.text,
                                description: jobdescription.text,
                                salaryRate: salarycontroller.text,
                                locaion: locationecontroller.text,
                                contactinfo: contactinfocontroller.text),
                          );
                    }

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const SettingsPage(),
                    //     ));
                  }
                } else {
                  if (formkey.currentState!.validate()) {
                    if (selectedCategories.isEmpty) {
                      setState(() {
                        isCategoryValid = false;
                      });
                    } else {
                      context.read<JobBloc>().add(
                            JobEditEvent(
                                category: selectedCategories[0],
                                jobId: widget.job!.jobId,
                                title: titlecontroller.text,
                                description: jobdescription.text,
                                salaryRate: salarycontroller.text,
                                locaion: locationecontroller.text,
                                contactinfo: contactinfocontroller.text),
                          );
                    }

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const SettingsPage(),
                    //     ));
                  }
                }
              },
              icon: const Icon(Icons.done))
        ],
        title: Text(S.of(context).postjob,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocConsumer<JobBloc, JobState>(
              listener: (context, state) {
                if (state is JobError) {
                  showSnacBar(context, state.error);
                } else if (state is JobUploaded) {
                  showSnacBar(context, state.message);
                  titlecontroller.clear();
                  jobdescription.clear();
                  salarycontroller.clear();
                  locationecontroller.clear();
                  contactinfocontroller.clear();
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is Jobloading) {
                  return const Loader();
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      JobEditor(
                        controller: titlecontroller,
                        hintText: S.of(context).jobtitle,
                        maxLines: 1,
                        maxLength: 50,
                      ),
                      const SizedBox(height: 10),
                      JobEditor(
                        controller: jobdescription,
                        hintText: S.of(context).jobdescription,
                        maxLines: 5,
                        maxLength: 500,
                      ),
                      const SizedBox(height: 10),
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
                                          isCategoryValid: isCategoryValid,
                                          color: selectedCategories
                                                  .contains(category.name)
                                              ? WidgetStatePropertyAll(
                                                  AppPallete.accentColor)
                                              : WidgetStatePropertyAll(
                                                  Theme.of(context)
                                                      .inputDecorationTheme
                                                      .fillColor),
                                          onTap: () {
                                            setState(() {
                                              addCategories(category.name);
                                            });
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
                      const SizedBox(height: 20),
                      JobEditor(
                        controller: salarycontroller,
                        hintText: S.of(context).salaryrate,
                        maxLines: 1,
                        maxLength: 20,
                      ),
                      const SizedBox(height: 10),
                      JobEditor(
                        controller: locationecontroller,
                        hintText: S.of(context).location,
                        maxLines: 1,
                        maxLength: 20,
                      ),
                      const SizedBox(height: 10),
                      JobEditor(
                        controller: contactinfocontroller,
                        hintText: S.of(context).contactinfo,
                        maxLines: 1,
                        maxLength: 30,
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
