import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/entities/models/job.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/jobs/presentation/widgets/job_editor.dart';

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
  List<String> selectedTopic = [];
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
                    context.read<JobBloc>().add(
                          JobUpload(
                              title: titlecontroller.text,
                              description: jobdescription.text,
                              salaryRate: salarycontroller.text,
                              locaion: locationecontroller.text,
                              contactinfo: contactinfocontroller.text),
                        );

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const SettingsPage(),
                    //     ));
                  }
                } else {
                  if (formkey.currentState!.validate()) {
                    context.read<JobBloc>().add(
                          JobEditEvent(
                              jobId: widget.job!.jobId,
                              title: titlecontroller.text,
                              description: jobdescription.text,
                              salaryRate: salarycontroller.text,
                              locaion: locationecontroller.text,
                              contactinfo: contactinfocontroller.text),
                        );

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
        title: Text('Post job',
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
                        hintText: 'Job title',
                        maxLines: 1,
                        maxLength: 50,
                      ),
                      const SizedBox(height: 10),
                      JobEditor(
                        controller: jobdescription,
                        hintText: 'Job description',
                        maxLines: 5,
                        maxLength: 500,
                      ),
                      const SizedBox(height: 10),
                      JobEditor(
                        controller: salarycontroller,
                        hintText: 'Salary rate',
                        maxLines: 1,
                        maxLength: 20,
                      ),
                      const SizedBox(height: 10),
                      JobEditor(
                        controller: locationecontroller,
                        hintText: 'Location',
                        maxLines: 1,
                        maxLength: 20,
                      ),
                      const SizedBox(height: 10),
                      JobEditor(
                        controller: contactinfocontroller,
                        hintText: 'Contact info',
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
