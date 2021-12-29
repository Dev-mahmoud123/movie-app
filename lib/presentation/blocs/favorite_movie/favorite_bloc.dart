import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/local_use_case/check_if_favorite_movie.dart';
import 'package:movie_app/domain/usecases/local_use_case/delete_movie.dart';
import 'package:movie_app/domain/usecases/local_use_case/get_favorite_movie.dart';
import 'package:movie_app/domain/usecases/local_use_case/save_movie.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavoriteMovie;
  final GetFavoriteMovies getFavoriteMovies;

  FavoriteBloc({
    required this.saveMovie,
    required this.deleteFavoriteMovie,
    required this.checkIfFavoriteMovie,
    required this.getFavoriteMovies,
  }) : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      if (event is ToggleFavoriteMovieEvent) {
        if (event.isFavorite) {
          await deleteFavoriteMovie(MovieParams(event.movieEntity.id));
        } else {
          await saveMovie(event.movieEntity);
        }
        final response =
            await checkIfFavoriteMovie(MovieParams(event.movieEntity.id));
        return response.fold(
          (l) => emit(FavoriteMovieError()),
          (r) => emit(IsMovieFavorite(r)),
        );
      } else if (event is LoadFavoriteMovieEvent) {
        final response = await getFavoriteMovies(NoParams());
        return response.fold(
          (l) => emit(FavoriteMovieError()),
          (r) => emit(FavoriteMovieLoaded(r)),
        );
      } else if (event is DeleteFavoriteMovieEvent) {
        await deleteFavoriteMovie(MovieParams(event.movieId));
        final response = await getFavoriteMovies(NoParams());
        return response.fold(
          (l) => emit(FavoriteMovieError()),
          (r) => emit(FavoriteMovieLoaded(r)),
        );
      } else if (event is CheckIfFavoriteMovieEvent) {
        final response = await checkIfFavoriteMovie(MovieParams(event.movieId));
        return response.fold(
          (l) => emit(FavoriteMovieError()),
          (r) => emit(IsMovieFavorite(r)),
        );
      }
    });
  }
}
