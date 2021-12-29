part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();
}

class LoadVideoEvent extends VideosEvent{

  final int movieId;


  const LoadVideoEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];

}