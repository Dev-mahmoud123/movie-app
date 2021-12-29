import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_bloc.dart';
import 'package:movie_app/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:movie_app/presentation/journeys/search_movie/search_movie_card.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/presentation/widgets/app_error_widget.dart';
import 'package:movie_app/presentation/widgets/loading.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc;

  CustomSearchDelegate(this.searchBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.greySubtitle1,
        border: InputBorder.none,
      ),
      appBarTheme: AppBarTheme(
          elevation: 2.0,
          color: context.read<ThemeCubit>().state == Themes.dark
              ? AppColor.vulcan
              : Colors.white),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? null : query = "";
        },
        icon: Icon(
          Icons.clear,
          color: query.isEmpty
              ? Colors.grey
              : context.read<ThemeCubit>().state == Themes.dark
                  ? AppColor.violet
                  : AppColor.violet,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: context.read<ThemeCubit>().state == Themes.dark
            ? Colors.white
            : AppColor.vulcan,
        size: Sizes.dimen_12.h.toDouble(),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(SearchTermChangedEvent(query));
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is SearchMovieLoading) {
          return const Center(
            child: Loading(),
          );
        } else if (state is SearchMovieError) {
          return AppErrorWidget(
            errorType: state.appErrorType,
            onPressed: () {
              searchBloc.add(
                SearchTermChangedEvent(query),
              );
            },
          );
        } else if (state is SearchMovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Sizes.dimen_40.w.toDouble()),
              child: Center(
                child: Text(
                  TranslationConstants.noSearchedMovie.tr(context),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) =>
                SearchMovieCard(movie: movies[index]),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
