import 'package:flutter/cupertino.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movie_app/presentation/journeys/movie_details/movie_details_screen.dart';
import 'package:movie_app/presentation/journeys/movie_details/movie_detials_arguments.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_screen.dart';

import 'journeys/home/home_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const HomeScreen(),
        RouteList.movieDetails: (context) => MovieDetailsScreen(
              movieDetailsArguments:
                  MovieDetailsArguments(setting.arguments as int),
            ),
        RouteList.watchTrailer: (context) => WatchVideoScreen(
              watchVideoArguments:
                  WatchVideoArguments(setting.arguments as List<VideoEntity>),
            ),
        RouteList.favorite: (context) => const FavoriteScreen(),
      };
}
