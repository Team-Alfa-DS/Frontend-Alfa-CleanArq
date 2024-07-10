part of 'tagSearch_bloc.dart';

abstract class TagSearchState extends Equatable {
  const TagSearchState();

  @override
  List<Object?> get props => [];
}

class TagSearchInit extends TagSearchState {}

class TagSearchLoading extends TagSearchState {}

class TagSearchSuccess extends TagSearchState {
  final List<String> tags;

  const TagSearchSuccess({ required this.tags});

  @override
  List<Object?> get props => [tags];
}

class TagSearchFailure extends TagSearchState {
  final Failure failure;

  const TagSearchFailure({ required this.failure});

  @override
  List<Object?> get props => [failure];
}