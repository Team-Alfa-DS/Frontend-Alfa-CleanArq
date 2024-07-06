part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInit extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchResult result;

  const SearchSuccess({ required this.result});

  @override
  List<Object?> get props => [result];
}

class SearchFailure extends SearchState {
  final Failure failure;

  const SearchFailure({ required this.failure});

  @override
  List<Object?> get props => [failure];
}