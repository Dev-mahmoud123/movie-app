import 'package:movie_app/domain/entities/movie_entity.dart';

class MoviesModel extends MovieEntity {
  final bool? video;
  final int id;
  final double voteAverage;
  final String overview;
  final String releaseDate;
  final int? voteCount;
  final bool? adult;
  final String backdropPath;
  final String title;
  final List<int>? genreIds;
  final String? originalLanguage;
  final String posterPath;
  final double? popularity;
  final String? mediaType;

  const MoviesModel(
      {this.video,
      required this.voteAverage,
      required this.overview,
      required this.releaseDate,
      this.voteCount,
      this.adult,
      required this.backdropPath,
      required this.title,
      this.genreIds,
      required this.id,
      this.originalLanguage,
      required this.posterPath,
      this.popularity,
      this.mediaType})
      : super(
            posterPath: posterPath,
            backdropPath: backdropPath,
            id: id,
            title: title,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            overview: overview);

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      video: json['video'],
      voteAverage: json['vote_average'].toDouble() ?? 0.0,
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteCount: json['vote_count'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'].toString(),
      title: json['title'],
      genreIds: json['genre_ids'].cast<int>(),
      id: json['id'],
      originalLanguage: json['original_language'],
      popularity: json['popularity'],
      mediaType: json['media_type'],
      posterPath: json['poster_path'].toString(),
    );
  }
}
