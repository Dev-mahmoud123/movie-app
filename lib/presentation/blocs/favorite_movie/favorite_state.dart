part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}
class FavoriteMovieLoaded extends FavoriteState {
  final List<MovieEntity> movieEntity;

  const FavoriteMovieLoaded(this.movieEntity);
  @override
  List<Object> get props => [movieEntity];

}
class FavoriteMovieError extends FavoriteState {}

class IsMovieFavorite extends FavoriteState {
  final bool isFavorite;

  const IsMovieFavorite(this.isFavorite);
  @override
  List<Object> get props => [isFavorite];
}

