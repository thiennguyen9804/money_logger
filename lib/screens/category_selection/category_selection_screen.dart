import 'package:flutter/material.dart';

import '../../models/categories.dart';
import '../../models/transaction.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({
    this.selectedCategory,
    required this.initialTransactionType,
    super.key,
  });

  final TransactionCategory? selectedCategory;
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
    final categories = _tabIndex == 0
        ? expenseTransactionCategories
        : incomeTransactionCategories;

    return DefaultTabController(
      length: 2,
      initialIndex: _tabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Category'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Expense'),
              Tab(text: 'Income'),
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
                      'No categories available',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'There are no categories for this type',
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
                        leading: Icon(category.icon, color: category.color),
                        title: Text(category.label),
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
