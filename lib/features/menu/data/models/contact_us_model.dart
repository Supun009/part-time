import 'package:parttime/features/menu/domain/entities/contact_us.dart';

class ContactUsModel extends Contacts {
  ContactUsModel({
    required super.title,
    required super.description,
  });

  factory ContactUsModel.fromMap(Map<String, dynamic> map) {
    return ContactUsModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
