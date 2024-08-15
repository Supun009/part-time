import 'package:flutter/material.dart';
import 'package:parttime/features/jobs/presentation/pages/add_job_page.dart';
import 'package:parttime/features/jobs/presentation/pages/my_jobs_page.dart';
import 'package:parttime/features/jobs/presentation/widgets/topics_tile.dart';

class JobManagerPage extends StatelessWidget {
  const JobManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Manager',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            TopicTile(
              icon: Icons.add,
              text: 'Post job',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JobPostPage(),
                    ));
              },
            ),
            TopicTile(
              icon: Icons.work,
              text: 'My jobs',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyJobsPage(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
