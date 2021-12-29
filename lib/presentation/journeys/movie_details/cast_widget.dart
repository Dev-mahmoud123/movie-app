import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/presentation/blocs/cast_bloc/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state is CastLoaded) {
          return SizedBox(
            height: Sizes.dimen_140.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.casts.length,
              itemBuilder: (context, index) {
                final castEntity = state.casts[index];
                return SizedBox(
                  height: Sizes.dimen_100.h,
                  width: Sizes.dimen_160.w,
                  child: Card(
                    elevation: 1.0,
                    margin: EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_8.w,
                      vertical: Sizes.dimen_4.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Sizes.dimen_8.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${ApiConstants.baseImageUrl}${castEntity.profilePath}",
                              height: Sizes.dimen_100.h,
                              width: Sizes.dimen_160.w,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => const Center(
                                  child: Icon(Icons.info_outline)),
                              placeholder: (context , url) => const Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Sizes.dimen_16.w),
                          child: Text(
                            castEntity.name,
                            style: context.read<ThemeCubit>().state ==
                                    Themes.dark
                                ? Theme.of(context).textTheme.vulcanBodyText2
                                : Theme.of(context).textTheme.whiteBodyText2,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Sizes.dimen_16.w,
                            right: Sizes.dimen_8.w,
                            bottom: Sizes.dimen_2.h,
                          ),
                          child: Text(
                            castEntity.character,
                            style:
                                context.read<ThemeCubit>().state == Themes.dark
                                    ? Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.black54)
                                    : Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.white54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
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
