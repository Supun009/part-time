import 'package:parttime/features/menu/domain/entities/faq.dart';

class FaqModel extends FAQ {
  FaqModel({
    required super.description,
    required super.title,
  });

  factory FaqModel.fromMap(Map<String, dynamic> map) {
    return FaqModel(
      description: map['description'] ?? '',
      title: map['title'] ?? '',
    );
  }
}
