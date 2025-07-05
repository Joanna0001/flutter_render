import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class FilterBottomSheet extends StatelessWidget {
  final VoidCallback onApply;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;

  const FilterBottomSheet({
    super.key,
    required this.onApply,
    required this.minPriceController,
    required this.maxPriceController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '筛选',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '价格区间',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: minPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '最低价',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text('-'),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: maxPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '最高价',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                onApply();
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '应用筛选',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void show({
    required BuildContext context,
    required VoidCallback onApply,
    required TextEditingController minPriceController,
    required TextEditingController maxPriceController,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => FilterBottomSheet(
        onApply: onApply,
        minPriceController: minPriceController,
        maxPriceController: maxPriceController,
      ),
    );
  }
}
