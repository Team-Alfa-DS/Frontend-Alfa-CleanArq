import 'package:equatable/equatable.dart';

abstract class CategoryDetailEvent extends Equatable {
  const CategoryDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoryDetail extends CategoryDetailEvent {
  final String categoryId;
  final int page;
  final int perPage;

  const LoadCategoryDetail(
      {required this.categoryId, required this.page, required this.perPage});

  @override
  List<Object?> get props => [categoryId];
}
