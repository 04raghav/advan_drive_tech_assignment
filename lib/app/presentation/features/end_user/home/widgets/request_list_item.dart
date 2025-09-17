import 'package:flutter/material.dart';
import 'package:quick_order_app/app/data/models/request_model.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';
import 'package:quick_order_app/app/presentation/features/end_user/home/widgets/status_tag.dart';

class RequestListItem extends StatelessWidget {
  final RequestModel request;

  const RequestListItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    String itemsPreview = request.items.map((e) => e.name).take(3).join(', ');

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemsPreview, style: AppTextStyles.cardTitle, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text("ID: ${request.id}", style: AppTextStyles.cardSubtitle),
                ],
              ),
            ),
            StatusTag(status: request.status),
          ],
        ),
      ),
    );
  }
}