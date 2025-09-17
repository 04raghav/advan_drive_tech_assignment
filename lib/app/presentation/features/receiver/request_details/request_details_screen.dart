import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';
import 'package:quick_order_app/app/core/utils/common_snackbar.dart';
import 'package:quick_order_app/app/data/models/item_model.dart';
import 'package:quick_order_app/app/data/models/request_model.dart';
import 'package:quick_order_app/app/data/providers/request_provider.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_button.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_loader.dart';
import 'package:quick_order_app/app/presentation/features/end_user/home/widgets/status_tag.dart';

class RequestDetailsScreen extends StatefulWidget {
  final RequestModel request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  late List<ItemModel> _itemsToConfirm;

  @override
  void initState() {
    super.initState();
    _itemsToConfirm = List.from(widget.request.items);
  }

  void _toggleItemConfirmation(ItemModel item) {
    setState(() {
      if (_itemsToConfirm.any((element) => element.id == item.id)) {
        _itemsToConfirm.removeWhere((element) => element.id == item.id);
      } else {
        _itemsToConfirm.add(item);
      }
    });
  }

  Future<void> _confirmRequest() async {
    final requestProvider = Provider.of<RequestProvider>(context, listen: false);

    try {
      final List<String> confirmedItemNames = _itemsToConfirm.map((item) => item.name).toList();

      final success = await requestProvider.confirmRequest(
        widget.request.id,
        confirmedItemNames,
      );

      if (success && mounted) {
        showSnackBar(
          context: context,
          title: 'Success',
          message: 'Request confirmation processed successfully!',
        );
        Navigator.pop(context); // Go back to receiver home
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details', style: AppTextStyles.heading2),
      ),
      body: Consumer<RequestProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Request ID: ${widget.request.id}', style: AppTextStyles.bodyBold),
                const SizedBox(height: 8),
                Text('Status:', style: AppTextStyles.body),
                StatusTag(status: widget.request.status),
                const SizedBox(height: 16),
                Text('Requested Items:', style: AppTextStyles.heading3),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.request.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.request.items[index];
                      final isConfirmed = _itemsToConfirm.any((element) => element.id == item.id);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: CheckboxListTile(
                          title: Text(item.name, style: AppTextStyles.body),
                          value: isConfirmed,
                          onChanged: (bool? newValue) {
                            _toggleItemConfirmation(item);
                          },
                          activeColor: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ),
                CommonButton(
                  text: 'Confirm Selected Items',
                  onPressed: _confirmRequest,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}