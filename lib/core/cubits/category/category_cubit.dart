import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parttime/features/jobs/domain/entities/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void updatecategoryList(List<JobCategory> categories) {
    if (categories.isEmpty) {
      emit(CategoryInitial());
    } else {
      emit(CategoriesState(categoryList: categories));
    }
  }
}
