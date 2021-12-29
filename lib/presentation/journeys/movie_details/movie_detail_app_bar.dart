import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/data/tables/movie_table.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/blocs/favorite_movie/favorite_bloc.dart';
import 'package:movie_app/presentation/blocs/favorite_movie/favorite_bloc.dart';
import 'package:movie_app/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';

class MovieDetailAppBar extends StatelessWidget {
  final MovieDetailsEntity movieDetailsEntity;

  const MovieDetailAppBar({Key? key, required this.movieDetailsEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: Sizes.dimen_12.h.toDouble(),
          ),
          color: context.read<ThemeCubit>().state == Themes.dark
              ? Colors.white
              : AppColor.vulcan,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is IsMovieFavorite) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<FavoriteBloc>(context).add(
                    ToggleFavoriteMovieEvent(
                      MovieEntity.fromMovieDetailEntity(movieDetailsEntity),
                      state.isFavorite,
                    ),
                  );
                },
                icon: Icon(
                  state.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: context.read<ThemeCubit>().state == Themes.dark
                      ? Colors.white
                      : AppColor.vulcan,
                  size: Sizes.dimen_12.h.toDouble(),
                ),
              );
            } else {
              return IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color:  context.read<ThemeCubit>().state == Themes.dark
                      ? Colors.white
                      : AppColor.vulcan,
                  size: Sizes.dimen_12.h.toDouble(),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
