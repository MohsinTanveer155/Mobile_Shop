import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_shop/config/app_constants.dart';
import 'package:mobile_shop/config/colors.dart';
import 'package:mobile_shop/gen/l10n/app_localizations.dart';
import 'package:mobile_shop/providers/settings_provider.dart';

class CurrencyScreen extends ConsumerStatefulWidget {
  const CurrencyScreen({super.key});

  @override
  ConsumerState<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends ConsumerState<CurrencyScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentCurrency = ref.watch(currencyProvider);

    final filteredCurrencies = AppConstants.supportedCurrencies.where((c) {
      final query = _searchQuery.toLowerCase();
      return c.name.toLowerCase().contains(query) ||
          c.code.toLowerCase().contains(query) ||
          c.symbol.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectCurrency),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: l10n.searchCurrency,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredCurrencies.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                final currency = filteredCurrencies[index];
                final isSelected = currentCurrency.code == currency.code;

                return ListTile(
                  onTap: () {
                    ref.read(currencyProvider.notifier).setCurrency(currency);
                    Navigator.of(context).pop();
                  },
                  title: Text(currency.displayName),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(currency.symbol, style: const TextStyle(fontSize: 18, color: AppColors.textSecondary)),
                      const SizedBox(width: 16),
                      isSelected
                          ? Icon(Icons.check_circle, color: AppColors.primary)
                          : const Icon(Icons.radio_button_unchecked, color: AppColors.border),
                    ],
                  ),
                  selected: isSelected,
                  selectedTileColor: AppColors.primary.withOpacity(0.05),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}