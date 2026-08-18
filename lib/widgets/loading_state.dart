import 'package:flutter/material.dart';
import '../config/colors.dart';

class LoadingState extends StatelessWidget {
  final String? message;
  final bool fullScreen;

  const LoadingState({
    super.key,
    this.message,
    this.fullScreen = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepIndigo),
          strokeWidth: 3,
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (fullScreen) {
      return Center(child: content);
    }

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(child: content),
    );
  }
}

class SkeletonLoader extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext) itemBuilder;
  final EdgeInsetsGeometry padding;

  const SkeletonLoader({
    super.key,
    this.itemCount = 5,
    required this.itemBuilder,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return Opacity(
          opacity: 0.5 + (0.5 * _controller.value),
          child: widget.itemBuilder(context),
        );
      },
    );
  }
}
