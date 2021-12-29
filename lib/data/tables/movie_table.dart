import 'package:hive/hive.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
part 'movie_table_generated.dart';

@HiveType(typeId: 0)
class MovieTable extends MovieEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterPath;

  const MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
  }) : super(
          title: title,
          posterPath: posterPath,
          id: id,
          backdropPath: "",
          voteAverage: 0.0,
          releaseDate: "",
          overview: "",
        );

  factory MovieTable.fromMovieEntity(MovieEntity movieEntity) {
    return MovieTable(
      title: movieEntity.title,
      posterPath: movieEntity.posterPath,
      id: movieEntity.id,
    );
  }
}
