import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/colors.dart';
import '../models/product.dart';
import '../providers/app_providers.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_state.dart';
import '../widgets/product_card.dart';
import '../widgets/role_guard.dart';
import 'add_edit_product_screen.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  final bool embedded;

  const ProductListScreen({
    super.key,
    this.embedded = false,
  });

  @override
  ConsumerState<ProductListScreen> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  String _searchQuery = '';

  void _editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditProductScreen(
          product: product,
        ),
      ),
    );
  }

  Future<void> _deleteProduct(Product product) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text(
            'Are you sure you want to delete "${product.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    try {
      final serviceAsync = ref.read(posServiceProvider);

      if (!serviceAsync.hasValue) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Product service is not ready. Please try again.',
            ),
          ),
        );
        return;
      }

      final service = serviceAsync.value!;

      service.deleteProduct(product.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${product.name} deleted successfully',
          ),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to delete product: $e',
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }

    // Invalidate the provider outside the try-catch to ensure the list refreshes.
    ref.invalidate(posServiceProvider);
  }

  @override
  Widget build(BuildContext context) {
    final serviceAsync = ref.watch(posServiceProvider);

    final scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        automaticallyImplyLeading: !widget.embedded,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add Product',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddEditProductScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditProductScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
      body: serviceAsync.when(
        loading: () {
          return const LoadingState(
            message: 'Loading products...',
          );
        },
        error: (error, stackTrace) {
          return EmptyState(
            icon: Icons.error_outline,
            title: 'Unable to Load Products',
            subtitle:
                'There was an error loading products. Please try again.',
            onActionPressed: () {
              ref.invalidate(posServiceProvider);
            },
            actionLabel: 'Retry',
            iconColor: AppColors.error,
          );
        },
        data: (service) {
          final query = _searchQuery.trim().toLowerCase();

          final filteredProducts = service.products.where((product) {
            if (query.isEmpty) {
              return true;
            }

            final name = product.name.toLowerCase();
            final brand = product.brand?.toLowerCase() ?? '';
            final model = product.model?.toLowerCase() ?? '';

            return name.contains(query) ||
                brand.contains(query) ||
                model.contains(query);
          }).toList();

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(posServiceProvider);

              await Future<void>.delayed(
                const Duration(milliseconds: 300),
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Search products by name, brand, model...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                tooltip: 'Clear Search',
                                onPressed: () {
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),

                  if (filteredProducts.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: EmptyState(
                          icon: Icons.inventory_2,
                          title: _searchQuery.isEmpty
                              ? 'No Products Yet'
                              : 'No Products Found',
                          subtitle: _searchQuery.isEmpty
                              ? 'Add products to start managing your inventory.'
                              : 'No products match your search. Try different keywords.',
                          onActionPressed: _searchQuery.isEmpty
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const AddEditProductScreen(),
                                    ),
                                  );
                                }
                              : () {
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                          actionLabel: _searchQuery.isEmpty
                              ? 'Add Product'
                              : 'Clear Search',
                        ),
                      ),
                    )
                  else
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final crossCount = (constraints.maxWidth / 200)
                            .floor()
                            .clamp(2, 4)
                            .toInt();

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(
                            16,
                            0,
                            16,
                            80,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossCount,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.64,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];

                            return ProductCard(
                              product: product,
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  builder: (sheetContext) {
                                    return _buildProductDetailsSheet(
                                      product,
                                    );
                                  },
                                );
                              },
                              onEditTap: () {
                                _editProduct(product);
                              },
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );

    if (widget.embedded) {
      return scaffold;
    }

    return RoleGuard(
      child: scaffold,
    );
  }

  Widget _buildProductDetailsSheet(Product product) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 12),

              if (product.brand != null &&
                  product.brand!.trim().isNotEmpty)
                Text(
                  'Brand: ${product.brand}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

              if (product.model != null &&
                  product.model!.trim().isNotEmpty)
                Text(
                  'Model: ${product.model}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

              const SizedBox(height: 12),

              Text(
                'Price: Rs ${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 4),

              Text(
                'Stock: ${product.quantity}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _editProduct(product);
                      },
                      child: const Text('Edit'),
                    ),
                  ),

                  const SizedBox(width: 8),

                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    tooltip: 'Delete',
                    onPressed: () {
                      Navigator.pop(context);
                      _deleteProduct(product);
                    },
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