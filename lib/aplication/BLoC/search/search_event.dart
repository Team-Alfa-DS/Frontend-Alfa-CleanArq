part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchSent extends SearchEvent {
  final int page;
  final int perpage;
  final List<String> tags;
  final String? term;

  const SearchSent(this.page, this.perpage, this.tags, this.term);

  @override
  List<Object?> get props => [page, perpage, tags, term];
}