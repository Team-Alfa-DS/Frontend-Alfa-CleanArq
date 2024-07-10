import 'package:equatable/equatable.dart';

abstract class CategoryDetailEvent extends Equatable {
  const CategoryDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoryDetail extends CategoryDetailEvent {
  final int page;
  final int perPage;

  const LoadCategoryDetail({required this.page, required this.perPage});

  @override
  List<Object?> get props => [];
}
