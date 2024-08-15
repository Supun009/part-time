import 'package:parttime/features/menu/domain/entities/about_us.dart';

class AboutUsModel extends AoutUS {
  AboutUsModel({
    required super.title,
    required super.description,
  });

  factory AboutUsModel.fromMap(Map<String, dynamic> map) {
    return AboutUsModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
