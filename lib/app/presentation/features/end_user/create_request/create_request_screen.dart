import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order_app/app/core/utils/common_snackbar.dart';
import 'package:quick_order_app/app/data/providers/request_provider.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_loader.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_button.dart';
import 'package:quick_order_app/app/presentation/features/end_user/create_request/widgets/item_entry_tile.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final _textController = TextEditingController();
  final List<String> _items = [];

  void _addItem() {
    if (_textController.text.trim().isNotEmpty) {
      setState(() {
        _items.insert(0, _textController.text.trim());
        _textController.clear();
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  Future<void> _submitRequest() async {
    if (_items.isEmpty) {
      showSnackBar(
        context: context,
        title: 'Empty Request',
        message: 'Please add at least one item before submitting.',
        isSuccess: false,
      );
      return;
    }

    final requestProvider = Provider.of<RequestProvider>(context, listen: false);
    
    final formattedItems = _items.map((name) => {'name': name}).toList();

    try {
      final success = await requestProvider.createRequest(formattedItems);
      if (success && mounted) {
        showSnackBar(
          context: context,
          title: 'Success',
          message: 'Your request has been submitted!',
        );
        Navigator.pop(context);
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
        title: Text('Create New Request', style: AppTextStyles.heading2),
      ),
      body: Consumer<RequestProvider>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? const LoadingIndicator()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                hintText: 'Add item (e.g., Milk)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 40),
                            onPressed: _addItem,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: _items.isEmpty
                            ? Center(child: Text('No items added yet.', style: AppTextStyles.subheading))
                            : ListView.builder(
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  return ItemEntryTile(
                                    itemName: _items[index],
                                    onRemove: () => _removeItem(index),
                                  );
                                },
                              ),
                      ),
                      CommonButton(text: 'Submit Request', onPressed: _submitRequest),
                    ],
                  ),
                );
        },
      ),
    );
  }
}