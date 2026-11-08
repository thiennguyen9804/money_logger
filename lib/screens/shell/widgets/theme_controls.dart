import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme/theme_bloc.dart';
import '../../../blocs/theme/theme_event.dart';
import '../../../blocs/theme/theme_state.dart';

class ThemeControls extends StatelessWidget {
  const ThemeControls({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final mode = state.mode;
        return Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark mode'),
                subtitle: Text(mode == ThemeMode.dark ? 'Enabled' : 'Disabled'),
                value: mode == ThemeMode.dark,
                onChanged: (enabled) {
                  themeBloc.add(
                    SetThemeMode(enabled ? ThemeMode.dark : ThemeMode.light),
                  );
                },
              ),
              OverflowBar(
                children: [
                  TextButton(
                    onPressed: () =>
                        themeBloc.add(const SetThemeMode(ThemeMode.light)),
                    child: const Text('Light'),
                  ),
                  TextButton(
                    onPressed: () =>
                        themeBloc.add(const SetThemeMode(ThemeMode.dark)),
                    child: const Text('Dark'),
                  ),
                  TextButton(
                    onPressed: () => themeBloc.add(const ToggleThemeMode()),
                    child: const Text('Toggle'),
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
