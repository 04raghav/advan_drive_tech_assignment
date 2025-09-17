import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';
import 'package:quick_order_app/app/data/models/item_model.dart';

class FulfillmentItemTile extends StatelessWidget {
  final ItemModel item;
  final bool isFound;
  final ValueChanged<bool?> onChanged;

  const FulfillmentItemTile({
    super.key,
    required this.item,
    required this.isFound,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: CheckboxListTile(
          title: Text(item.name, style: AppTextStyles.body),
          value: isFound,
          onChanged: onChanged,
          secondary: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isFound ? AppColors.statusConfirmed : AppColors.statusNotFound,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isFound ? "Found" : "Not Found",
              style: AppTextStyles.statusTag,
            ),
          ),
          activeColor: AppColors.statusConfirmed,
        ),
      ),
    );
  }
}