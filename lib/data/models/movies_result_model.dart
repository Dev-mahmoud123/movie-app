
import 'package:movie_app/data/models/movies_model.dart';

class MoviesResultModel {
 late List<MoviesModel> movies;


  MoviesResultModel({required this.movies,});

  MoviesResultModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies = <MoviesModel>[];
      json['results'].forEach((v) {
        movies.add(MoviesModel.fromJson(v));
      });
    }
  }

}

