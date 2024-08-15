import 'package:parttime/features/menu/domain/entities/app_version.dart';

class AppVersionModel extends AppVersion {
  AppVersionModel({
    required super.title,
    required super.description,
  });

  factory AppVersionModel.fromMap(Map<String, dynamic> map) {
    return AppVersionModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
