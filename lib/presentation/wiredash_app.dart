import 'package:flutter/material.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';
import 'package:provider/src/provider.dart';
import 'package:wiredash/wiredash.dart';

import 'blocs/theme_bloc/theme_cubit.dart';

class WireDashApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String languageCode;
  final Widget child;

  const WireDashApp({
    Key? key,
    required this.navigatorKey,
    required this.child,
    required this.languageCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'movie-app-svncbuz',
      secret: 'JQAPacmNfk7MX8BHxlHLPL7Vzlr1ZdYv',
      navigatorKey: navigatorKey,
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(
          languageCode: languageCode,
        ),
      ),
      theme: WiredashThemeData(
          brightness: context.read<ThemeCubit>().state == Themes.dark
              ? Brightness.dark
              : Brightness.light,
          primaryColor: AppColor.royalBlue,
          secondaryColor: AppColor.violet,
          secondaryBackgroundColor:
              context.read<ThemeCubit>().state == Themes.dark
                  ? AppColor.vulcan
                  : Colors.white,
          dividerColor: AppColor.vulcan),
      child: child,
    );
  }
}
