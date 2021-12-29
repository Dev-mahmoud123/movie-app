import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/models/cast_crew_result_model.dart';
import 'package:movie_app/data/models/movie_detaitls_model.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/data/models/movies_result_model.dart';
import 'package:movie_app/data/models/video_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MoviesModel>> getTrending();

  Future<List<MoviesModel>> getPopular();

  Future<List<MoviesModel>> getPlayingNow();

  Future<List<MoviesModel>> getComingSoon();

  Future<List<MoviesModel>> getSearchedMovie(String searchTerm);

  Future<MovieDetailsModel> getMovieDetails(int id);

  Future<List<CastModel>> getCastCrew(int id);

  Future<List<VideoModel>> getVideos(int id);
}

class MovieRemoteDataSourceImp extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImp(this._client);

  @override
  Future<List<MoviesModel>> getTrending() async {
    final response = await _client.get("trending/movie/day");
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MoviesModel>> getComingSoon() async {
    final response = await _client.get("movie/upcoming");
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MoviesModel>> getPlayingNow() async {
    final response = await _client.get("movie/now_playing");
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MoviesModel>> getPopular() async {
    final response = await _client.get("movie/popular");
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int id) async {
    final response = await _client.get("movie/$id");
    final movie = MovieDetailsModel.fromJson(response);
    return movie;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await _client.get("movie/$id/credits");
    final cast = CastCrewResultModel.fromJson(response).cast;
    return cast;
  }

  @override
  Future<List<VideoModel>> getVideos(int id) async {
    final response = await _client.get("movie/$id/videos");
    final videos = VideoResultModel.fromJson(response).videos;
    return videos;
  }

  @override
  Future<List<MoviesModel>> getSearchedMovie(String searchTerm) async {
    final response = await _client.getWithParams(
      "search/movie",
      {
        'query': searchTerm,
      },
    );
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }
}
