import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/local_use_case/get_preferred__theme.dart';
import 'package:movie_app/domain/usecases/local_use_case/update_theme.dart';

part 'theme_state.dart';

enum Themes{light , dark}

class ThemeCubit extends Cubit<Themes> {

  final GetPreferredTheme getPreferredTheme;
  final UpdateTheme updateTheme;

  ThemeCubit({
    required this.getPreferredTheme,
    required this.updateTheme,
  }) : super(Themes.dark);


  Future<void> toggleTheme() async {
    await updateTheme(state == Themes.dark ? 'light' : 'dark');
    loadPreferredTheme();
  }

  void loadPreferredTheme() async {
    final response = await getPreferredTheme(NoParams());
    emit(
      response.fold(
            (l) => Themes.dark,
            (r) => r == 'dark' ? Themes.dark : Themes.light,
      ),
    );
  }
}
