import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/blocs/cast_bloc/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/favorite_movie/favorite_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movie_app/presentation/blocs/videos_bloc/videos_bloc.dart';
import 'package:movie_app/presentation/journeys/movie_details/movie_detials_arguments.dart';
import 'package:movie_app/presentation/journeys/movie_details/videos_widget.dart';
import 'package:movie_app/presentation/widgets/button.dart';
import 'package:movie_app/presentation/widgets/loading.dart';

import 'big_poster.dart';
import 'cast_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieDetailsArguments movieDetailsArguments;

  const MovieDetailsScreen({Key? key, required this.movieDetailsArguments})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsBloc movieDetailsBloc;
  late CastBloc castBloc;
  late VideosBloc videosBloc;
  late FavoriteBloc favoriteBloc;

  @override
  void initState() {
    super.initState();
    movieDetailsBloc = getItInstance<MovieDetailsBloc>();
    castBloc = movieDetailsBloc.castBloc;
    videosBloc = movieDetailsBloc.videosBloc;
    favoriteBloc = movieDetailsBloc.favoriteBloc;
    movieDetailsBloc
        .add(MovieDetailsLoadEvent(widget.movieDetailsArguments.movieId));
  }

  @override
  void dispose() {
    super.dispose();
    movieDetailsBloc.close();
    castBloc.close();
    videosBloc.close();
    favoriteBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailsBloc>.value(value: movieDetailsBloc),
          BlocProvider<CastBloc>.value(value: castBloc),
          BlocProvider<VideosBloc>.value(value: videosBloc),
          BlocProvider<FavoriteBloc>.value(value: favoriteBloc),
        ],
        child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(child: Loading());
            } else if (state is MovieDetailsLoaded) {
              final movieDetails = state.movieDetailsEntity;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(
                      movie: movieDetails,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w.toDouble(),
                        vertical: Sizes.dimen_8.h.toDouble(),
                      ),
                      child: Text(
                        movieDetails.overview,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w.toDouble(),
                      ),
                      child: Text(
                        TranslationConstants.cast.tr(context),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    const CastWidget(),
                    VideosWidget(
                      videoBloc: videosBloc,
                    )
                  ],
                ),
              );
            } else if (state is MovieDetailsError) {
              return Container();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
