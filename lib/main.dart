import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'blocs/locale/locale_bloc.dart';
import 'blocs/locale/locale_state.dart';
import 'services/locale_preference_store.dart';
import 'l10n/generated/app_localizations.dart';
import 'shared/theme/theme_data.dart';
import 'screens/shell/app_shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(
          create: (_) => LocaleBloc(
            preferenceStore: LocalePreferenceStore(),
            deviceLocale: WidgetsBinding.instance.platformDispatcher.locale,
          ),
        ),
        BlocProvider(create: (_) => LedgerBloc(const [])),
      ],
      child: const _AppContent(),
    );
  }
}

class _AppContent extends StatelessWidget {
  const _AppContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, localeState) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
            locale: localeState.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeState.mode,
            home: const AppShell(),
          );
        },
      ),
    );
  }
}
