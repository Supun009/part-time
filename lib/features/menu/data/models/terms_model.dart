import 'package:parttime/features/menu/domain/entities/terms.dart';

class TermsModel extends Terms {
  TermsModel({
    required super.description,
    required super.title,
  });

  factory TermsModel.fromMap(Map<String, dynamic> map) {
    return TermsModel(
      description: map['description'] ?? '',
      title: map['title'] ?? '',
    );
  }
}
