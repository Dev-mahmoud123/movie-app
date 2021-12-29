import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:movie_app/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_expanded_list_item.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_list_items.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';
import 'package:movie_app/presentation/widgets/app_dialog.dart';
import 'package:movie_app/presentation/widgets/logo.dart';
import 'package:wiredash/wiredash.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  /// TODO: Show Dialog
  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: TranslationConstants.about,
        description: TranslationConstants.description,
        buttonText: TranslationConstants.ok,
        image: Image.asset(
          "assets/pngs/tmdb_logo.png",
          height: Sizes.dimen_32.h,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.dimen_300.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 4.0),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                right: Sizes.dimen_8.w,
                left: Sizes.dimen_8.w,
              ),
              child: Logo(
                key: const ValueKey("logo_image_key"),
                height: Sizes.dimen_14.h,
              ),
            ),
            NavigationListItems(
              title: TranslationConstants.favoriteMovies.tr(context),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.favorite);
              },
            ),
            NavigationExpandedListItem(
              title: TranslationConstants.language.tr(context),
              onPressed: (index) {
                BlocProvider.of<LanguageBloc>(context).add(
                  ToggleLanguageEvent(Languages.languages[index]),
                );
              },
              children:
                  Languages.languages.map((e) => e.value.tr(context)).toList(),
            ),
            NavigationListItems(
              title: TranslationConstants.feedback.tr(context),
              onPressed: () {
                Navigator.of(context).pop();
                Wiredash.of(context)?.show();
              },
            ),
            NavigationListItems(
              title: TranslationConstants.about.tr(context),
              onPressed: () {
                Navigator.of(context).pop();
                _showDialog(context);
              },
            ),
            const Spacer(),
            BlocBuilder<ThemeCubit, Themes>(
              builder: (context, theme) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    icon: Icon(
                      theme == Themes.dark
                          ? Icons.brightness_4_outlined
                          : Icons.brightness_4,
                      color: context.read<ThemeCubit>().state == Themes.dark
                          ? Colors.white
                          : AppColor.vulcan,
                      size: Sizes.dimen_16.h,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: Sizes.dimen_16.h),
          ],
        ),
      ),
    );
  }
}
