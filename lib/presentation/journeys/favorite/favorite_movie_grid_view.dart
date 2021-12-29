import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/blocs/favorite_movie/favorite_bloc.dart';
import 'package:movie_app/presentation/journeys/movie_details/movie_details_screen.dart';
import 'package:movie_app/presentation/journeys/movie_details/movie_detials_arguments.dart';

class FavoriteMovieGridView extends StatelessWidget {
  final List<MovieEntity> movies;

  const FavoriteMovieGridView({Key? key, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 7.0,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteList.movieDetails, arguments: movies[index].id);
          },
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w.toDouble()),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Sizes.dimen_10.w.toDouble()),
                  child: CachedNetworkImage(
                      imageUrl:
                          '${ApiConstants.baseImageUrl}${movies[index].posterPath}'),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<FavoriteBloc>(context)
                          .add(DeleteFavoriteMovieEvent(movies[index].id));
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
