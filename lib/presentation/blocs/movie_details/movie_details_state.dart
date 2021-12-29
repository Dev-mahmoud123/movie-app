part of 'movie_details_bloc.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}
class MovieDetailsLoading extends MovieDetailsState {}
class MovieDetailsError extends MovieDetailsState {}
class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsEntity movieDetailsEntity;

  const MovieDetailsLoaded(this.movieDetailsEntity);

  @override
  List<Object> get props => [movieDetailsEntity];
}
