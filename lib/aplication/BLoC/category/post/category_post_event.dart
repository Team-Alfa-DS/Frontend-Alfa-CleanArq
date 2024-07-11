import 'package:alpha_gymnastic_center/domain/interfaces/category_interfaces.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryPostEvent extends Equatable {
  const CategoryPostEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoryPost extends CategoryPostEvent {
  final CreateCategoryRequest createCategoryRequest;

  const LoadCategoryPost({required this.createCategoryRequest});

  @override
  List<Object?> get props => [createCategoryRequest];
}
