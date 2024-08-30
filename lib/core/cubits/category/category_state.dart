part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoriesState extends CategoryState {
  final List<JobCategory> categoryList;

  CategoriesState({required this.categoryList});
}
