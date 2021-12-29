import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/app_language_local_data_source.dart';
import 'package:movie_app/data/data_sources/app_theme_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_lacal_data_source.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/app_repository_impl.dart';
import 'package:movie_app/data/repositories/movie_repository_imp.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/local_use_case/check_if_favorite_movie.dart';
import 'package:movie_app/domain/usecases/local_use_case/delete_movie.dart';
import 'package:movie_app/domain/usecases/local_use_case/get_favorite_movie.dart';
import 'package:movie_app/domain/usecases/local_use_case/get_preferred__language.dart';
import 'package:movie_app/domain/usecases/local_use_case/get_preferred__theme.dart';
import 'package:movie_app/domain/usecases/local_use_case/save_movie.dart';
import 'package:movie_app/domain/usecases/local_use_case/update_language.dart';
import 'package:movie_app/domain/usecases/local_use_case/update_theme.dart';
import 'package:movie_app/presentation/blocs/favorite_movie/favorite_bloc.dart';
import 'package:movie_app/presentation/blocs/theme_bloc/theme_cubit.dart';
import '../domain/usecases/remote_use_case/get_cast.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_coming_soon.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_movie_details.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_playing_now.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_popular.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_searched_movie.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_trending.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_videos.dart';
import 'package:movie_app/presentation/blocs/cast_bloc/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_carousal/movie_carousal_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_bloc.dart';
import 'package:movie_app/presentation/blocs/videos_bloc/videos_bloc.dart';

final getItInstance = GetIt.I;

Future inti() async {
  // All dependencies goes here

  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImp(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImp());

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImp(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<AppRepository>(
          () => AppRepositoryImpl(getItInstance() , getItInstance()));

  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
          () => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<ThemeLocalDataSource>(
          () => ThemeLocalDataSourceImpl());

  /// TODO :  ALL REMOTE USE CASES ------- >
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<GetSearchedMovie>(
      () => GetSearchedMovie(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetails>(
      () => GetMovieDetails(getItInstance()));

  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));

  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  /// TODO : ALL LOCAL USE CASES ------- >
  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));

  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
      () => DeleteFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
      () => CheckIfFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<UpdateLanguage>(
          () => UpdateLanguage(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(
          () => GetPreferredLanguage(getItInstance()));

  getItInstance.registerLazySingleton<UpdateTheme>(
          () => UpdateTheme(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredTheme>(
          () => GetPreferredTheme(getItInstance()));

  /// TODO : BLOC DI ------ >
  getItInstance.registerFactory(() => MovieCarousalBloc(
        getTrending: getItInstance(),
        movieBackdropBloc: getItInstance(),
      ));
  getItInstance.registerFactory(() => MovieBackdropBloc());
  getItInstance.registerFactory(() => MovieTabbedBloc(
        getPopular: getItInstance(),
        getPlayingNow: getItInstance(),
        getComingSoon: getItInstance(),
      ));

  getItInstance.registerFactory(
    () => MovieDetailsBloc(
        getMovieDetails: getItInstance(),
        castBloc: getItInstance(),
        videosBloc: getItInstance(),
        favoriteBloc: getItInstance()),
  );


  getItInstance.registerFactory(
    () => CastBloc(
      getCast: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => VideosBloc(
      getVideos: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => SearchBloc(
      searchedMovie: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));

  getItInstance.registerSingleton<ThemeCubit>(ThemeCubit(
    updateTheme: getItInstance(),
    getPreferredTheme: getItInstance(),
  ));

  getItInstance.registerFactory(
    () => FavoriteBloc(
      saveMovie: getItInstance(),
      checkIfFavoriteMovie: getItInstance(),
      getFavoriteMovies: getItInstance(),
      deleteFavoriteMovie: getItInstance(),
    ),
  );
}
