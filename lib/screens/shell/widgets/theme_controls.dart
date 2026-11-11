import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme/theme_bloc.dart';
import '../../../blocs/theme/theme_event.dart';
import '../../../blocs/theme/theme_state.dart';
import '../../../l10n/generated/app_localizations.dart';

class ThemeControls extends StatelessWidget {
  const ThemeControls({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ThemeBloc>();
    final l = AppLocalizations.of(context)!;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final mode = state.mode;
        return Card(
          child: Column(
            children: [
              SwitchListTile(
                title: Text(l.darkMode),
                subtitle: Text(mode == ThemeMode.dark ? l.enabled : l.disabled),
                value: mode == ThemeMode.dark,
                onChanged: (enabled) => bloc.add(
                  SetThemeMode(enabled ? ThemeMode.dark : ThemeMode.light),
                ),
              ),
              OverflowBar(
                children: [
                  TextButton(
                    onPressed: () =>
                        bloc.add(const SetThemeMode(ThemeMode.light)),
                    child: Text(l.light),
                  ),
                  TextButton(
                    onPressed: () =>
                        bloc.add(const SetThemeMode(ThemeMode.dark)),
                    child: Text(l.dark),
                  ),
                  TextButton(
                    onPressed: () => bloc.add(const ToggleThemeMode()),
                    child: Text(l.toggle),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
