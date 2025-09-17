import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';

class ItemEntryTile extends StatelessWidget {
  final String itemName;
  final VoidCallback onRemove;
  
  const ItemEntryTile({
    super.key,
    required this.itemName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(itemName, style: AppTextStyles.body),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline, color: AppColors.statusNotFound),
          onPressed: onRemove,
        ),
      ),
    );
  }
}