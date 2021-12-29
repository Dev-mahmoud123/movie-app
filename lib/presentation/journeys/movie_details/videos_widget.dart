import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/blocs/videos_bloc/videos_bloc.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_screen.dart';
import 'package:movie_app/presentation/widgets/button.dart';

class VideosWidget extends StatelessWidget {
  final VideosBloc videoBloc;

  const VideosWidget({Key? key, required this.videoBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosState>(
      builder: (context, state) {
        if (state is VideosLoaded && state.videos.iterator.moveNext()) {
          final videos = state.videos;
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
            child: Button(
              text: TranslationConstants.videoTrailer,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteList.watchTrailer, arguments: videos);
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
