import 'package:parttime/features/jobs/domain/entities/category.dart';

class CategoryModel extends JobCategory {
  CategoryModel({
    required super.name,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['title'] ?? '',
    );
  }
}
