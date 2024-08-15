import 'package:parttime/core/entities/models/job.dart';

class JobModel extends Job {
  JobModel({
    required super.email,
    required super.title,
    required super.description,
    required super.salaryRate,
    required super.location,
    required super.contactInfo,
    required super.jobId,
    required super.createdAt,
  });

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      email: map['email'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      salaryRate: map['salary'] ?? '',
      location: map['location'] ?? '',
      contactInfo: map['contactInfo'] ?? '',
      jobId: map['_id'] ?? '',
      createdAt: _parseDateTime(map['createdAt']),
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is DateTime) {
      return value;
    }
    return DateTime.now(); // Default value if parsing fails
  }
}
