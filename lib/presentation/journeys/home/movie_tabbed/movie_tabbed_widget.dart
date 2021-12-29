import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_list_view_builder.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_tab_constants.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_tab_title_widget.dart';
import 'package:movie_app/presentation/widgets/app_error_widget.dart';

class MovieTabbedWidget extends StatefulWidget {
  const MovieTabbedWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieTabbedWidget> createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget>
    with SingleTickerProviderStateMixin {
  MovieTabbedBloc get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedBloc>(context);
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabbedBloc
        .add(MovieTabbedChangedEvent(currentTabIndex: currentTabIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h.toDouble()),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < MovieTabConstants.movieTabs.length; i++)
                    MovieTitleWidget(
                      title: MovieTabConstants.movieTabs[i].title,
                      onTap: () => _onTabTapped(i),
                      isSelected: MovieTabConstants.movieTabs[i].index ==
                          state.currentTabIndex,
                    ),
                ],
              ),
              if (state is MovieTabChanged)
                state.movies.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            TranslationConstants.noMovies.tr(context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      )
                    : Expanded(
                        child: MovieListViewBuilder(movies: state.movies),
                      ),
              if (state is MovieTabError)
                AppErrorWidget(
                  errorType: state.appError,
                  onPressed: () => movieTabbedBloc.add(MovieTabbedChangedEvent(
                    currentTabIndex: state.currentTabIndex,
                  )),
                )
            ],
          ),
        );
      },
    );
  }

  _onTabTapped(int index) {
    movieTabbedBloc.add(MovieTabbedChangedEvent(currentTabIndex: index));
  }
}
