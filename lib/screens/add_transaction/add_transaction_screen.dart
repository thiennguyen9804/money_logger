import 'package:flutter/material.dart';

import '../../models/transaction.dart';
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
    final amount = parsePositiveMinorUnits(_draft.amountText);
    if (amount == null) {
      setState(() {
        _amountError = 'Enter an amount greater than zero.';
      });
      return;
    }
    if (_draft.category == null) {
      setState(() {
        _amountError = 'Select a category.';
      });
      return;
    }
    if (_draft.category!.type != _draft.type) {
      setState(() {
        _amountError = 'Category type does not match transaction type.';
      });
      return;
    }
    Navigator.of(context).pop(_draft);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amountIsValid = parsePositiveMinorUnits(_draft.amountText) != null;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add Transaction'),
        actions: [
          TextButton(
            onPressed: amountIsValid && _draft.category != null ? _save : null,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Semantics(
        container: true,
        label: 'Add transaction form',
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
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: '0.00',
                    prefixText: r'$ ',
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
                  leading: Icon(
                    _draft.category?.icon ?? Icons.category_outlined,
                  ),
                  title: Text(
                    _draft.category?.label ?? 'Select Category',
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
                  title: const Text('Date and time'),
                  subtitle: Text(_formatDraftDateTime(_draft.createdAt)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _selectDateTime,
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('More Details'),
                  subtitle: Text(
                    _draft.eventContext == null ||
                            _draft.eventContext == 'No event'
                        ? 'Add an event or campaign'
                        : _draft.eventContext!,
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
                    decoration: const InputDecoration(
                      labelText: 'Event or campaign',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      for (final event in transactionEvents)
                        DropdownMenuItem(value: event, child: Text(event)),
                    ],
                    onChanged: (event) {
                      setState(() => _draft.eventContext = event);
                    },
                  ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: amountIsValid ? _save : null,
                  icon: const Icon(Icons.check),
                  label: const Text('Save'),
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
