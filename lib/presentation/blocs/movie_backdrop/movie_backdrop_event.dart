part of 'movie_backdrop_bloc.dart';

abstract class MovieBackdropEvent extends Equatable {
  const MovieBackdropEvent();
  @override
  List<Object?> get props => [];
}

class MovieBackdropChangeEvent extends MovieBackdropEvent{
  final MovieEntity movie ;

  const MovieBackdropChangeEvent(this.movie);

  @override
  List<Object?> get props => [movie];
}