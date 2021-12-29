import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/num_extension.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/screen_utils/screen_utils.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/presentation/journeys/movie_details/movie_detail_app_bar.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

class BigPoster extends StatelessWidget {
  final MovieDetailsEntity movie;

  const BigPoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.3),
                Theme.of(context).primaryColor,
              ])),
          child: CachedNetworkImage(
            imageUrl: "${ApiConstants.baseImageUrl}${movie.posterPath}",
            width: ScreenUtil.screenWidth,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ListTile(
            title: Text(
              movie.title,
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(
              movie.releaseDate,
              style: Theme.of(context).textTheme.greySubtitle1,
            ),
            trailing: Text(
              movie.voteAverage.convertToPercentageString(),
                style: Theme.of(context).textTheme.violetHeadLine6,
            ),
          ),
        ),
        Positioned(
          left: Sizes.dimen_16.w.toDouble(),
          right: Sizes.dimen_16.w.toDouble(),
          top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
          child:MovieDetailAppBar(
            movieDetailsEntity: movie,
          ),
        ),
      ],
    );
  }
}
