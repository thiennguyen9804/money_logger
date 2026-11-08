import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(mode: ThemeMode.light)) {
    on<SetThemeMode>((event, emit) => emit(ThemeState(mode: event.mode)));
    on<ToggleThemeMode>((event, emit) {
      emit(
        ThemeState(
          mode: state.mode == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light,
        ),
      );
    });
  }
}
