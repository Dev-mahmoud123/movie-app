import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchVideoScreen extends StatefulWidget {
  final WatchVideoArguments watchVideoArguments;

  const WatchVideoScreen({Key? key, required this.watchVideoArguments})
      : super(key: key);

  @override
  State<WatchVideoScreen> createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  late List<VideoEntity> videos;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    videos = widget.watchVideoArguments.videos;
    _controller = YoutubePlayerController(
        initialVideoId: videos[0].key!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          TranslationConstants.videoTrailer,
        ),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
              playedColor: Colors.amber, handleColor: Colors.amberAccent),
        ),
        builder: (context, player) => Column(
          children: [
            player,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < videos.length; i++)
                      Container(
                        height: 120,
                        padding: EdgeInsets.symmetric(
                            vertical: Sizes.dimen_8.h,
                            horizontal: Sizes.dimen_16.w),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _controller.load(videos[i].key!);
                                _controller.play();
                              },
                              child: CachedNetworkImage(
                                width: Sizes.dimen_140.w,
                                imageUrl: YoutubePlayer.getThumbnail(
                                  videoId: videos[i].key!,
                                  quality: ThumbnailQuality.high,
                                ),
                                errorWidget: (context, url, error) => const Center(
                                    child: Icon(Icons.info_outline)),
                                placeholder: (context , url) => const Center(child: CircularProgressIndicator()),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.dimen_8.w),
                                child: Text(
                                  videos[i].title!,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
