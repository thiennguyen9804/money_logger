import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/category_localizations.dart';
import '../../shared/widgets/category_icon.dart';
import '../../shared/widgets/type_segmented_button.dart';
import '../category_selection/category_selection_screen.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late final TransactionDraft _draft;
  late final TextEditingController _amountController;
  String? _amountError;

  @override
  void initState() {
    super.initState();
    _draft = TransactionDraft();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _draft.createdAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || date == null) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_draft.createdAt),
    );
    if (!mounted || time == null) {
      return;
    }
    setState(() {
      _draft.createdAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _save() {
    final l = AppLocalizations.of(context)!;
    final amount = parsePositiveMinorUnits(
      _draft.amountText,
      Localizations.localeOf(context),
    );
    if (amount == null) {
      setState(() {
        _amountError = l.enterAmountError;
      });
      return;
    }
    if (_draft.category == null) {
      setState(() {
        _amountError = l.selectCategoryError;
      });
      return;
    }
    if (_draft.category!.type != _draft.type) {
      setState(() {
        _amountError = l.categoryTypeError;
      });
      return;
    }
    Navigator.of(context).pop(_draft);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;
    final isVnd = Localizations.localeOf(context).languageCode == 'vi';
    final amountIsValid =
        parsePositiveMinorUnits(
          _draft.amountText,
          Localizations.localeOf(context),
        ) !=
        null;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          tooltip: l.back,
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(l.navAddTransaction),
        actions: [
          TextButton(
            onPressed: amountIsValid && _draft.category != null ? _save : null,
            child: Text(l.save),
          ),
        ],
      ),
      body: Semantics(
        container: true,
        label: l.addTransactionForm,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, bottomInset + 16),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TypeSegmentedButton(
                  selectedType: _draft.type,
                  onSelected: (newType) {
                    setState(() {
                      _draft.type = newType;
                      if (_draft.category != null &&
                          _draft.category!.type != newType) {
                        _draft.category = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _amountController,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  autofocus: true,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: !isVnd,
                  ),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: l.amount,
                    hintText: isVnd ? l.amountHintVnd : l.amountHintUsd,
                    prefixText: isVnd ? null : r'$ ',
                    suffixText: isVnd ? ' ₫' : null,
                    errorText: _amountError,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _draft.amountText = value;
                      _amountError = null;
                    });
                  },
                  onSubmitted: (_) {
                    if (amountIsValid) {
                      _save();
                    }
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CategoryIcon(
                    icon: _draft.category?.icon ?? Icons.category_outlined,
                    iconAssetPath: _draft.category?.iconAssetPath,
                  ),
                  title: Text(
                    _draft.category == null
                        ? l.selectCategory
                        : localizedCategoryLabel(l, _draft.category!),
                    style: theme.textTheme.titleMedium,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final category = await Navigator.of(context).push<Category>(
                      MaterialPageRoute(
                        builder: (context) => CategorySelectionScreen(
                          selectedCategory: _draft.category,
                          initialTransactionType: _draft.type,
                        ),
                      ),
                    );
                    if (mounted && category != null) {
                      setState(() {
                        _draft.category = category;
                        _draft.type = category.type;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_outlined),
                  title: Text(l.dateTime),
                  subtitle: Text(_formatDraftDateTime(_draft.createdAt)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _selectDateTime,
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.moreDetails),
                  subtitle: Text(
                    _draft.eventContext == null ||
                            _draft.eventContext == transactionEvents.first
                        ? l.addEvent
                        : _localizedEventLabel(l, _draft.eventContext!),
                  ),
                  trailing: Icon(
                    _draft.isMoreDetailsExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                  onTap: () {
                    setState(() {
                      _draft.isMoreDetailsExpanded =
                          !_draft.isMoreDetailsExpanded;
                    });
                  },
                ),
                if (_draft.isMoreDetailsExpanded)
                  DropdownButtonFormField<String>(
                    initialValue:
                        _draft.eventContext ?? transactionEvents.first,
                    decoration: InputDecoration(
                      labelText: l.eventCampaign,
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      for (final event in transactionEvents)
                        DropdownMenuItem(
                          value: event,
                          child: Text(_localizedEventLabel(l, event)),
                        ),
                    ],
                    onChanged: (event) {
                      setState(() => _draft.eventContext = event);
                    },
                  ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: amountIsValid ? _save : null,
                  icon: const Icon(Icons.check),
                  label: Text(l.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _formatDraftDateTime(DateTime dateTime) {
  final local = dateTime.toLocal();
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '${local.day}/${local.month}/${local.year} at $hour:$minute';
}

String _localizedEventLabel(AppLocalizations l, String event) =>
    switch (event) {
      'No event' => l.noEvent,
      'Holiday spending' => l.holidaySpending,
      'Home renovation' => l.homeRenovation,
      'Birthday celebration' => l.birthdayCelebration,
      _ => event,
    };
