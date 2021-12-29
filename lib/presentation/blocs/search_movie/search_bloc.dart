import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/movie_searh_params.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_searched_movie.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchedMovie searchedMovie;

  SearchBloc({required this.searchedMovie}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchTermChangedEvent) {
        emit(SearchMovieLoading());
        if (event.searchTerm.length > 2) {
          emit(SearchMovieLoading());
          final response = await searchedMovie(
              MovieSearchParams(searchTerm: event.searchTerm));
          return response.fold(
            (l) => emit(SearchMovieError(l.appErrorType)),
            (r) => emit(SearchMovieLoaded(r)),
          );
        }
      }
    });
  }
}
