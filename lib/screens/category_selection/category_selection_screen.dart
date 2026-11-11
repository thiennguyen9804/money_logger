import 'package:flutter/material.dart';

import '../../models/categories.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/category_localizations.dart';
import '../../shared/widgets/category_icon.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({
    this.selectedCategory,
    required this.initialTransactionType,
    super.key,
  });

  final Category? selectedCategory;
  final TransactionType initialTransactionType;

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  late int _tabIndex;

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.initialTransactionType == TransactionType.income ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final categories = _tabIndex == 0
        ? ExpenseCategory.values
        : IncomeCategory.values;

    return DefaultTabController(
      length: 2,
      initialIndex: _tabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.selectCategory),
          bottom: TabBar(
            tabs: [
              Tab(text: l.expense),
              Tab(text: l.income),
            ],
            onTap: (index) => setState(() => _tabIndex = index),
          ),
        ),
        body: categories.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.category_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l.noCategories,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l.noCategoriesType,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: categories.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final selected = category == widget.selectedCategory;
                  return Semantics(
                    button: true,
                    selected: selected,
                    label:
                        '${category.label} category${selected ? ', selected' : ''}',
                    child: Card(
                      color: selected
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : null,
                      child: ListTile(
                        leading: CategoryIcon(
                          icon: category.icon,
                          iconAssetPath: category.iconAssetPath,
                        ),
                        title: Text(localizedCategoryLabel(l, category)),
                        trailing: selected ? const Icon(Icons.check) : null,
                        onTap: () => Navigator.of(context).pop(category),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
