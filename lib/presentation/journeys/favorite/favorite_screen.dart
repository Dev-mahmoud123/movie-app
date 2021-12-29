
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/blocs/favorite_movie/favorite_bloc.dart';
import 'package:movie_app/presentation/journeys/favorite/favorite_movie_grid_view.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final FavoriteBloc favoriteBloc;

  @override
  void initState() {
    super.initState();
    favoriteBloc = getItInstance<FavoriteBloc>();
    favoriteBloc.add(LoadFavoriteMovieEvent());
  }

  @override
  void dispose() {
    super.dispose();
    favoriteBloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(TranslationConstants.favoriteMovies.tr(context)),
      ),
      body: BlocProvider.value(
         value: favoriteBloc,
        child: BlocBuilder<FavoriteBloc , FavoriteState>(
          builder: (context , state){
            if(state is FavoriteMovieLoaded){
              if(state.movieEntity.isEmpty){
                return Center(
                  child: Text(
                    TranslationConstants.noFavoriteMovie.tr(context),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                );
              }else {
                return FavoriteMovieGridView(
                  movies: state.movieEntity,
                );
              }
            }else {
             return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
