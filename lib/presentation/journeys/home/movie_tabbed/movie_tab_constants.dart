import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/tab.dart';

class MovieTabConstants {
  static List<Tab> movieTabs = [
    Tab(title:TranslationConstants.popular, index: 0),
    Tab(title: TranslationConstants.now, index: 1),
    Tab(title: TranslationConstants.soon, index: 2),
  ];
}
