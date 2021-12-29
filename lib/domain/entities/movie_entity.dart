import 'package:equatable/equatable.dart';

import 'movie_detail_entity.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final String backdropPath;
  final int id;
  final String title;
  final double voteAverage;
  final String releaseDate;
  final String overview;

  const MovieEntity({required this.posterPath,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview});

  @override
  List<Object?> get props => [id, title];

  @override
  bool get stringify => true;

  factory MovieEntity.fromMovieDetailEntity(
      MovieDetailsEntity movieDetailEntity) {
    return MovieEntity(
      posterPath: movieDetailEntity.posterPath,
      id: movieDetailEntity.id,
      backdropPath: movieDetailEntity.backdropPath,
      title: movieDetailEntity.title,
      voteAverage: movieDetailEntity.voteAverage.toDouble(),
      releaseDate: movieDetailEntity.releaseDate,
      overview: movieDetailEntity.overview,
    );
  }
}