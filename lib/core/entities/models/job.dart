class Job {
  final String jobId;
  final String email;
  final String title;
  final String description;
  final String salaryRate;
  final String location;
  final String contactInfo;
  final DateTime createdAt;

  Job({
    required this.email,
    required this.title,
    required this.description,
    required this.salaryRate,
    required this.location,
    required this.contactInfo,
    required this.jobId,
    required this.createdAt,
  });
}
