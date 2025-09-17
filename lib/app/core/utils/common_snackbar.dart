import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  bool isSuccess = true,
}) {
  final Widget snackBarContent = Material(
    borderRadius: BorderRadius.circular(12),
    elevation: 4,
    shadowColor: Colors.black.withOpacity(0.1),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isSuccess ? Colors.green.shade400 : Colors.red.shade400,
            width: 5,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSuccess ? Colors.green.shade800 : Colors.red.shade800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    ),
  );

  showTopSnackBar(
    Overlay.of(context),
    snackBarContent,
    displayDuration: const Duration(seconds: 2),
  );
}