part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchMovieLoading extends SearchState {}

class SearchMovieError extends SearchState {
   final AppErrorType appErrorType ;

  const SearchMovieError(this.appErrorType);
  @override
  List<Object> get props => [appErrorType];
}

class SearchMovieLoaded extends SearchState {
  final List<MovieEntity> movies;

  const SearchMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
