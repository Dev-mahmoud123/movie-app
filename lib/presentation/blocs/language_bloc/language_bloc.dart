import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/domain/entities/language_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/local_use_case/get_preferred__language.dart';
import 'package:movie_app/domain/usecases/local_use_case/update_language.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetPreferredLanguage getPreferredLanguage;
  final UpdateLanguage updateLanguage;

  LanguageBloc(
      {required this.getPreferredLanguage, required this.updateLanguage})
      : super(LanguageLoaded(Locale(Languages.languages[0].code))) {
    on<LanguageEvent>((event, emit)async {
      if (event is ToggleLanguageEvent) {
        await updateLanguage(event.language.code);
        add(LoadPreferredLanguageEvent());
      } else if (event is LoadPreferredLanguageEvent) {
        final response = await getPreferredLanguage(NoParams());
        return response.fold(
              (l) => emit(LanguageError()),
              (r) => emit(LanguageLoaded(Locale(r))),
        );
      }
    });
  }
}
