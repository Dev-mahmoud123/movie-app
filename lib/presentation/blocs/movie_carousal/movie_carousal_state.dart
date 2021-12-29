part of 'movie_carousal_bloc.dart';

abstract class MovieCarousalState extends Equatable {
  const MovieCarousalState();

  @override
  List<Object> get props => [];
}

class MovieCarousalInitial extends MovieCarousalState {}
class MovieCarousalLoading extends MovieCarousalState {}

class MovieCarousalError extends MovieCarousalState {
  final AppErrorType errorType;

  const MovieCarousalError(this.errorType);

}

class MovieCarousalLoaded extends MovieCarousalState {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarousalLoaded({
    required this.movies,
    this.defaultIndex = 0,
  }) ;
  @override
  List<Object> get props => [movies , defaultIndex];
}
