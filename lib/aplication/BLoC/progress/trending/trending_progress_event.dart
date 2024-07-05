part of 'trending_progress_bloc.dart';

abstract class TrendingProgressEvent extends Equatable {
  const TrendingProgressEvent();

  @override
  List<Object> get props => [];
}

class LoadTrendingProgress extends TrendingProgressEvent {}
