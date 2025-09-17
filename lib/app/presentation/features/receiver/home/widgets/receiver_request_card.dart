import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';
import 'package:quick_order_app/app/core/routes/route_names.dart';
import 'package:quick_order_app/app/data/models/request_model.dart';
import 'package:quick_order_app/app/presentation/features/end_user/home/widgets/status_tag.dart';

class ReceiverRequestCard extends StatelessWidget {
  final RequestModel request;

  const ReceiverRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.requestDetails,
            arguments: request,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Request ID: ${request.id}', style: AppTextStyles.bodySmall),
              const SizedBox(height: 8),
              Text(
                'Items: ${request.items.map((e) => e.name).join(', ')}',
                style: AppTextStyles.bodyBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusTag(status: request.status),
                  Text(
                    '${request.createdAt.day}/${request.createdAt.month}/${request.createdAt.year}',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}