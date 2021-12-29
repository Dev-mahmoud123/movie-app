import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/domain/usecases/remote_use_case/get_videos.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;
  VideosBloc({required this.getVideos}) : super(VideosInitial()) {
    on<VideosEvent>((event, emit) async {
      if(event is LoadVideoEvent){
        final Either<AppError, List<VideoEntity>> eitherResponse =
            await getVideos(MovieParams(event.movieId));
        return eitherResponse.fold(
              (l) => emit(NoVideos()),
              (r) => emit(VideosLoaded(r)),
        );
      }
    });
  }
}
