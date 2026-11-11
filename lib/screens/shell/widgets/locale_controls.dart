import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/locale/locale_bloc.dart';
import '../../../blocs/locale/locale_event.dart';
import '../../../l10n/generated/app_localizations.dart';

class LocaleControls extends StatelessWidget {
  const LocaleControls({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final locale = context.select((LocaleBloc b) => b.state.locale);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.language),
        title: Text(l.language),
        trailing: DropdownButton<Locale>(
          value: locale,
          onChanged: (value) {
            if (value != null)
              context.read<LocaleBloc>().add(LocaleSelectionChanged(value));
          },
          items: [
            DropdownMenuItem(
              value: const Locale('en', 'US'),
              child: Text(l.english),
            ),
            DropdownMenuItem(
              value: const Locale('vi', 'VN'),
              child: Text(l.vietnamese),
            ),
          ],
        ),
      ),
    );
  }
}
