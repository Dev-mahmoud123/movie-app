import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

class SearchMovieCard extends StatelessWidget {
  final MovieEntity movie;

  const SearchMovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteList.movieDetails, arguments: movie.id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_16.w.toDouble(),
          vertical: Sizes.dimen_2.h.toDouble(),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(Sizes.dimen_8.w.toDouble()),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.dimen_8.w.toDouble()),
                child: CachedNetworkImage(
                  imageUrl: "${ApiConstants.baseImageUrl}${movie.posterPath}",
                  width: Sizes.dimen_80.w.toDouble(),
                  errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.info_outline)),
                  placeholder: (context , url) => const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    height: Sizes.dimen_4.h.toDouble(),
                  ),
                  Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.greyCaption,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
