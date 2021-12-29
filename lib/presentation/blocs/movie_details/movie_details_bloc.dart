

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_movie_details.dart';
import 'package:movie_app/presentation/blocs/cast_bloc/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/favorite_movie/favorite_bloc.dart';
import 'package:movie_app/presentation/blocs/videos_bloc/videos_bloc.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetails getMovieDetails;
  final CastBloc castBloc;
  final VideosBloc videosBloc;
  final FavoriteBloc favoriteBloc;


  MovieDetailsBloc({
    required this.getMovieDetails,
    required this.castBloc,
    required this.videosBloc,
    required this.favoriteBloc,
  }) : super(MovieDetailsInitial()) {
    on<MovieDetailsEvent>((event, emit) async {
      emit(MovieDetailsLoading());
      if (event is MovieDetailsLoadEvent) {
        final movieEither = await getMovieDetails(MovieParams(event.movieId));
        favoriteBloc.add(CheckIfFavoriteMovieEvent(event.movieId));
        castBloc.add(LoadCastEvent(movieId: event.movieId));
        videosBloc.add(LoadVideoEvent(event.movieId));
        return movieEither.fold(
          (l) => emit(MovieDetailsError()),
          (r) {
            emit(MovieDetailsLoaded(r));
          },
        );

      }
    });
  }
}
