part of 'tagSearch_bloc.dart';

abstract class TagSearchEvent extends Equatable {
  const TagSearchEvent();

  @override
  List<Object?> get props => [];
}

class TagSearchSent extends TagSearchEvent {
  final int page;
  final int perpage;

  const TagSearchSent(this.page, this.perpage);

  @override
  List<Object?> get props => [page, perpage];
}