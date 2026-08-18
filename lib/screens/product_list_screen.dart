import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/colors.dart';
import '../providers/app_providers.dart';
import '../models/product.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_state.dart';
import '../widgets/product_card.dart';
import '../widgets/role_guard.dart';
import 'add_edit_product_screen.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  final bool embedded;

  const ProductListScreen({super.key, this.embedded = false});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  String _searchQuery = '';

  void _editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditProductScreen(product: product)),
    );
  }

  void _deleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(posServiceProvider).whenData((service) {
                service.deleteProduct(product.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} deleted successfully'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddEditProductScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditProductScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
      body: serviceAsync.when(
          loading: () => const LoadingState(message: 'Loading products...'),
          error: (err, stack) => EmptyState(
            icon: Icons.error_outline,
            title: 'Unable to Load Products',
            subtitle: 'There was an error loading products. Please try again.',
            onActionPressed: () => ref.refresh(posServiceProvider),
            actionLabel: 'Retry',
            iconColor: AppColors.error,
          ),
          data: (service) {
            // Filter products based on search
            final filteredProducts = service.products
                .where((p) =>
                    p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    (p.brand?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
                    (p.model?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false))
                .toList();

            return Column(
              children: [
                // Search and Filter Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search products by name, brand, model...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                  ),
                ),
                // Products Grid/List
                Expanded(
                  child: filteredProducts.isEmpty
                      ? EmptyState(
                          icon: Icons.inventory_2,
                          title: _searchQuery.isEmpty ? 'No Products Yet' : 'No Products Found',
                          subtitle: _searchQuery.isEmpty
                              ? 'Add products to start managing your inventory.'
                              : 'No products match your search. Try different keywords.',
                          onActionPressed: _searchQuery.isEmpty
                              ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const AddEditProductScreen(),
                                    ),
                                  )
                              : () => setState(() => _searchQuery = ''),
                          actionLabel: _searchQuery.isEmpty ? 'Add Product' : 'Clear Search',
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            final crossCount = (constraints.maxWidth / 200).floor().clamp(2, 4);
                            return GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossCount,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.72,
                              ),
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = filteredProducts[index];
                                return ProductCard(
                                  product: product,
                                  onTap: () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                    ),
                                    builder: (context) => _buildProductDetailsSheet(product),
                                  ),
                                  onEditTap: () => _editProduct(product),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
    );

    if (widget.embedded) return scaffold;
    return RoleGuard(child: scaffold);
  }

  Widget _buildProductDetailsSheet(Product product) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
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
            if (product.brand != null)
              Text('Brand: ${product.brand}', style: Theme.of(context).textTheme.bodyMedium),
            if (product.model != null)
              Text('Model: ${product.model}', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Text('Price: Rs ${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium),
            Text('Stock: ${product.quantity}', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _editProduct(product);
                    },
                    child: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteProduct(product);
                  },
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
