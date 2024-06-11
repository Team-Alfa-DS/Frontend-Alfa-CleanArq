import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/category.dart';

abstract class CategoryDetailState extends Equatable {
  const CategoryDetailState();

  @override
  List<Object?> get props => [];
}

class CategoryDetailInitial extends CategoryDetailState {}

class CategoryDetailLoading extends CategoryDetailState {}

class CategoryDetailLoaded extends CategoryDetailState {
  final List<Category> categories;

  const CategoryDetailLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryDetailFailed extends CategoryDetailState {
  final Failure failure;

  const CategoryDetailFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
