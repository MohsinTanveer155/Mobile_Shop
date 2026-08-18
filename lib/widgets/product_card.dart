import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/colors.dart';
import '../models/product.dart';
import 'status_badge.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;
  final bool showActions;
  final int lowStockThreshold;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onEditTap,
    this.onDeleteTap,
    this.showActions = true,
    this.lowStockThreshold = 5,
  });

  @override
  Widget build(BuildContext context) {
    final isLowStock = product.quantity <= lowStockThreshold;
    final isOutOfStock = product.quantity <= 0;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1.35,
              child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: AppColors.surfaceAlt,
                        child: const Icon(Icons.image, color: AppColors.textSecondary),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: AppColors.surfaceAlt,
                        child: const Icon(Icons.phone_android, color: AppColors.textSecondary, size: 36),
                      ),
                    )
                  : Container(
                      color: AppColors.surfaceAlt,
                      child: const Icon(Icons.phone_android, color: AppColors.textSecondary, size: 36),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.brand != null && product.brand!.isNotEmpty)
                                Text(
                                  product.brand!,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              Text(
                                product.model?.isNotEmpty == true ? product.model! : product.name,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (isOutOfStock)
                          StatusBadge.error(label: 'Out', icon: Icons.remove_circle_outline)
                        else if (isLowStock)
                          StatusBadge.warning(label: 'Low', icon: Icons.warning_amber),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Rs. ${product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.deepIndigo,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'Stock: ${product.quantity}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isLowStock ? AppColors.error : AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    if (showActions) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onTap,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                textStyle: const TextStyle(fontSize: 11),
                              ),
                              child: const Text('View'),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onEditTap,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                textStyle: const TextStyle(fontSize: 11),
                              ),
                              child: const Text('Edit'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
