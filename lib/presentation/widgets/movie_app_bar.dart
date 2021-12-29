import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_bloc.dart';
import 'package:movie_app/presentation/journeys/search_movie/custom_search_delegate.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Sizes.dimen_14.h.toDouble(),
        left: Sizes.dimen_16.w.toDouble(),
        right: Sizes.dimen_16.w.toDouble(),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              "assets/svgs/menu.svg",

              height: Sizes.dimen_16.h.toDouble(),
            ),
          ),
          Expanded(
            child: Logo(
              height: Sizes.dimen_24.w.toDouble(),
            ),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    CustomSearchDelegate(BlocProvider.of<SearchBloc>(context)),
              );
            },
            icon: Icon(
              Icons.search,
              size: Sizes.dimen_16.h.toDouble(),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
