import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/constants/enums.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';

class StatusTag extends StatelessWidget {
  final RequestStatus status;

  const StatusTag({super.key, required this.status});

  String get _text {
    switch (status) {
      case RequestStatus.confirmed:
        return 'Confirmed';
      case RequestStatus.partiallyFulfilled:
        return 'Partially Fulfilled';
      case RequestStatus.pending:
        return 'Pending';
    }
  }

  Color get _color {
    switch (status) {
      case RequestStatus.confirmed:
        return AppColors.statusConfirmed;
      case RequestStatus.partiallyFulfilled:
        return AppColors.statusPartiallyFulfilled;
      case RequestStatus.pending:
        return AppColors.statusPending;
    }
  }

  IconData get _icon {
    switch (status) {
      case RequestStatus.confirmed:
        return Icons.check_circle;
      case RequestStatus.partiallyFulfilled:
        return Icons.info;
      case RequestStatus.pending:
        return Icons.hourglass_empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, color: AppColors.white, size: 14),
          const SizedBox(width: 4),
          Text(_text, style: AppTextStyles.statusTag),
        ],
      ),
    );
  }
}