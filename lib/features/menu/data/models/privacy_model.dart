import 'package:parttime/features/menu/domain/entities/privacy.dart';

class PrivacyModel extends Privacy {
  PrivacyModel({
    required super.title,
    required super.description,
  });

  factory PrivacyModel.fromMap(Map<String, dynamic> map) {
    return PrivacyModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
