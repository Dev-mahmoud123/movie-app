
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/cast_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_cast.dart';

part 'cast_event.dart';

part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCast getCast;

  CastBloc({required this.getCast}) : super(CastInitial()) {
    on<CastEvent>((event, emit) async {
      if (event is LoadCastEvent) {
        final Either<AppError, List<CastEntity>> eitherResponse =
            await getCast(MovieParams(event.movieId));
        return eitherResponse.fold(
          (l) => emit(CastError()),
          (r) => emit(CastLoaded(casts: r)),
        );
      }
    });
  }
}
