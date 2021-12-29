import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/screen_utils/screen_utils.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/domain/usecases/local_use_case/get_preferred__language.dart';
import 'package:movie_app/presentation/app_localization.dart';
import 'package:movie_app/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:movie_app/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:movie_app/presentation/routes.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/presentation/wiredash_app.dart';
import 'fade_page_route_builder.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late LanguageBloc languageBloc;
  late ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();
    languageBloc = getItInstance<LanguageBloc>();
    languageBloc.add(LoadPreferredLanguageEvent());
    themeCubit = getItInstance<ThemeCubit>();
    themeCubit.loadPreferredTheme();
  }

  @override
  void dispose() {
    super.dispose();
    languageBloc.close();
    themeCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: languageBloc),
        BlocProvider<ThemeCubit>.value(value: themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        builder: (context, theme) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              if (state is LanguageLoaded) {
                return WireDashApp(
                  navigatorKey: _navigatorKey,
                  languageCode: state.locale.languageCode,
                  child: MaterialApp(
                    navigatorKey: _navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: "Movie App",
                    supportedLocales:
                        Languages.languages.map((e) => Locale(e.code)).toList(),
                    locale: state.locale,
                    localizationsDelegates: [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    theme: ThemeData(
                      brightness: theme == Themes.dark
                          ? Brightness.dark
                          : Brightness.light,
                      unselectedWidgetColor: AppColor.royalBlue,
                      primaryColor:
                          theme == Themes.dark ? AppColor.vulcan : Colors.white,
                      scaffoldBackgroundColor:
                          theme == Themes.dark ? AppColor.vulcan : Colors.white,
                      colorScheme: theme == Themes.dark
                          ? const ColorScheme.dark(
                              secondary: AppColor.royalBlue)
                          : const ColorScheme.light(secondary: Colors.white),
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      cardTheme: CardTheme(
                          color: theme == Themes.dark
                              ? Colors.white
                              : AppColor.vulcan),
                      textTheme: theme == Themes.dark
                          ? ThemeText.getTextTheme()
                          : ThemeText.getLightTextTheme(),
                      appBarTheme: AppBarTheme(
                        elevation: 0,
                        backgroundColor: theme == Themes.dark
                            ? AppColor.vulcan
                            : Colors.white,
                        titleTextStyle: TextStyle(
                          fontSize: Sizes.dimen_16,
                            color: theme == Themes.dark
                                ? Colors.white
                                : AppColor.vulcan),
                        iconTheme: IconThemeData(
                          color:  theme == Themes.dark
                              ? Colors.white
                              : AppColor.vulcan
                        )
                      ),
                    ),
                    builder: (context, child) {
                      return child!;
                    },
                    initialRoute: RouteList.initial,
                    onGenerateRoute: (RouteSettings settings) {
                      final routes = Routes.getRoutes(settings);
                      final WidgetBuilder builder = routes[settings.name]!;
                      return FadePageRouteBuilder(
                        builder: builder,
                        settings: settings,
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
