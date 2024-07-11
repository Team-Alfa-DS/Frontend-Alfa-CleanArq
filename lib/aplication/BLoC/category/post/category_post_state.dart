import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryPostState extends Equatable {
  const CategoryPostState();

  @override
  List<Object?> get props => [];
}

class CategoryPostInitial extends CategoryPostState {}

class CategoryPostLoading extends CategoryPostState {}

class CategoryPostLoaded extends CategoryPostState {
  final Category category;

  const CategoryPostLoaded(this.category);

  @override
  List<Object?> get props => [category];
}

class CategoryPostFailed extends CategoryPostState {
  final Failure failure;

  const CategoryPostFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
