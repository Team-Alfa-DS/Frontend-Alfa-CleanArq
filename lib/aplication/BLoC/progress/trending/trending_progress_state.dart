part of 'trending_progress_bloc.dart';

abstract class TrendingProgressState extends Equatable {
  const TrendingProgressState();

  @override
  List<Object> get props => [];
}

class TrendingProgressInitial extends TrendingProgressState {}

class TrendingProgressLoading extends TrendingProgressState {}

class TrendingProgressLoaded extends TrendingProgressState {
  final TrendingProgressResponse progress;

  const TrendingProgressLoaded({required this.progress});

  @override
  List<Object> get props => [progress];
}

class TrendingProgressError extends TrendingProgressState {
  final String message;

  const TrendingProgressError({required this.message});

  @override
  List<Object> get props => [message];
}
