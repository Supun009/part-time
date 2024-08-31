import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/admob/banner_add_widget.dart';
import 'package:parttime/core/admob/interstitialadwidget.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/core/entities/models/job.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/jobs/presentation/pages/add_job_page.dart';
import 'package:parttime/features/jobs/presentation/widgets/info_row.dart';

class JobDetailsPage extends StatefulWidget {
  final Job job;
  final bool? isMyjobpage;
  const JobDetailsPage({
    super.key,
    required this.job,
    this.isMyjobpage,
  });

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  InterstitialAdWidget interstitialAdWidget = InterstitialAdWidget();
  bool showContact = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isMyjobpage!) {}

    _loadCurrentUser();
  }

  String? userEmail;
  String? uId;

  Future<void> _loadCurrentUser() async {
    final userState = context.read<AppUserCubit>().state as AppUserLoggedIn;
    userEmail = userState.user.email;
    uId = userState.user.id;
  }

  void _reportJob() {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text(
            'Report Job',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please enter the reason for reporting this job:'),
              const SizedBox(height: 10),
              TextField(
                controller: reasonController,
                decoration:
                    InputDecoration(fillColor: Theme.of(context).primaryColor),

                maxLines: 1, // Allow multiple lines if needed
                maxLength: 100,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Report'),
              onPressed: () {
                final reason = reasonController.text.trim();
                if (reason.isNotEmpty) {
                  context.read<JobBloc>().add(
                        JobReportByidevent(
                          jobId: widget.job.jobId,
                          reason: reasonController.text,
                          userId: uId!,
                        ),
                      );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Job reported successfully')),

                  Navigator.of(context).pop();
                } else {
                  // Show a message if the reason is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a reason')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void onEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JobPostPage(
            job: widget.job,
            isMyjobpage: widget.isMyjobpage,
          ),
        ));
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String jobId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            'Delete Job',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to delete this job?',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'This action cannot be undone.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
              ),
              onPressed: () {
                context
                    .read<JobBloc>()
                    .add(JobRemoveByID(jobId: widget.job.jobId));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showContactInfo() {
    setState(() {
      showContact = !showContact;
    });

    interstitialAdWidget.loadInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            if (userEmail == widget.job.email && widget.isMyjobpage == true)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz),
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit();
                  } else if (value == 'delete') {
                    _showDeleteConfirmationDialog(context, widget.job.jobId);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ];
                },
              ),
            if (!widget.isMyjobpage!)
              IconButton(
                icon: const Icon(Icons.flag),
                onPressed: _reportJob,
                tooltip: 'Report Job',
              ),
          ],
          title: Text('Job Details',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocConsumer<JobBloc, JobState>(
                    listener: (context, state) {
                      if (state is JobError) {
                        showSnacBar(context, state.error);
                      }
                      if (state is JobReportCompleted) {
                        showSnacBar(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      return Card(
                        color: Theme.of(context).colorScheme.secondary,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.job.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.job.location,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.job.description,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 20),
                              InfoRow(
                                icon: Icons.money,
                                title: 'Salary rate:',
                                value: widget.job.salaryRate,
                              ),
                              const SizedBox(height: 15),
                              showContact || widget.isMyjobpage!
                                  ? InfoRow(
                                      icon: Icons.contact_phone,
                                      title: 'Contact:',
                                      value: widget.job.contactInfo,
                                    )
                                  : ElevatedButton(
                                      onPressed: showContactInfo,
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Contact',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '⚠️ Please be aware of scams. Verify the job details and employer before proceeding.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 15),
            const Center(
              child: BannerAdWidget(),
            ),
          ],
        ));
  }
}
