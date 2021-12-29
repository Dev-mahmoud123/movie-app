import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_trending.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousal_event.dart';

part 'movie_carousal_state.dart';

class MovieCarousalBloc extends Bloc<MovieCarousalEvent, MovieCarousalState> {
  GetTrending getTrending;
  MovieBackdropBloc movieBackdropBloc;

  MovieCarousalBloc({required this.getTrending , required this.movieBackdropBloc})
      : super(MovieCarousalInitial()) {
    on<MovieCarousalEvent>(
      (event, emit) async {
        emit(MovieCarousalLoading());
        if (event is CarousalLoadEvent) {
          final movieEither = await getTrending(NoParams());
          return movieEither.fold(
            (l) => emit(MovieCarousalError(l.appErrorType)),
            (movies) {
              movieBackdropBloc.add(MovieBackdropChangeEvent(movies[event.defaultIndex]));
              emit(MovieCarousalLoaded(
                  movies: movies, defaultIndex: event.defaultIndex));
            },
          );
        }
      },
    );
  }
}
