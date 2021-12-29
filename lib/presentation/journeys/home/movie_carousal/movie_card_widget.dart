import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/presentation/journeys/movie_details/movie_details_screen.dart';
import 'package:movie_app/presentation/journeys/movie_details/movie_detials_arguments.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieId;
  final String posterPath;

  const MovieCardWidget(
      {Key? key, required this.movieId, required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w.toDouble()),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(RouteList.movieDetails, arguments: movieId);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w.toDouble()),
          child: CachedNetworkImage(
            imageUrl: "${ApiConstants.baseImageUrl}$posterPath",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.info_outline)),
            placeholder: (context , url) => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
