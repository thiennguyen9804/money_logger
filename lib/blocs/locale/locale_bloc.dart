import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/locale_preference_store.dart';
import 'locale_event.dart';
import 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc({
    required LocalePreferenceStore preferenceStore,
    required Locale deviceLocale,
  }) : _preferenceStore = preferenceStore,
       super(
         LocaleState(
           locale: LocalePreferenceStore.localeFromDevice(deviceLocale),
         ),
       ) {
    on<LocalePreferenceLoaded>(_onPreferenceLoaded);
    on<LocaleSelectionChanged>(_onSelectionChanged);
    add(LocalePreferenceLoaded(deviceLocale));
  }

  final LocalePreferenceStore _preferenceStore;

  Future<void> _onPreferenceLoaded(
    LocalePreferenceLoaded event,
    Emitter<LocaleState> emit,
  ) async {
    final savedLocale = await _preferenceStore.read();
    emit(
      LocaleState(
        locale:
            savedLocale ??
            LocalePreferenceStore.localeFromDevice(event.deviceLocale),
      ),
    );
  }

  Future<void> _onSelectionChanged(
    LocaleSelectionChanged event,
    Emitter<LocaleState> emit,
  ) async {
    final localeId = LocalePreferenceStore.localeIdFor(event.locale);
    final locale = LocalePreferenceStore.localeFromId(localeId);
    if (locale == null) return;

    emit(LocaleState(locale: locale));
    await _preferenceStore.write(locale);
  }
}
