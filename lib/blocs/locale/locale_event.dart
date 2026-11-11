import 'package:flutter/material.dart';

sealed class LocaleEvent {
  const LocaleEvent();
}

final class LocalePreferenceLoaded extends LocaleEvent {
  const LocalePreferenceLoaded(this.deviceLocale);

  final Locale deviceLocale;
}

final class LocaleSelectionChanged extends LocaleEvent {
  const LocaleSelectionChanged(this.locale);

  final Locale locale;
}
