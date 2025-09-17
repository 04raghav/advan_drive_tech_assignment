import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order_app/app/data/providers/request_provider.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_loader.dart';
import 'package:quick_order_app/app/presentation/common_widgets/main_scaffold.dart';
import 'package:quick_order_app/app/presentation/features/receiver/home/widgets/receiver_request_card.dart';

class ReceiverHomeScreen extends StatefulWidget {
  const ReceiverHomeScreen({super.key});

  @override
  State<ReceiverHomeScreen> createState() => _ReceiverHomeScreenState();
}

class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RequestProvider>(context, listen: false).fetchRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Available Requests',
      body: Consumer<RequestProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingIndicator();
          }
          if (provider.requests.isEmpty) {
            return const Center(child: Text("No pending requests."));
          }
          return RefreshIndicator(
            onRefresh: () => provider.fetchRequests(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: provider.requests.length,
              itemBuilder: (context, index) {
                return ReceiverRequestCard(request: provider.requests[index]);
              },
            ),
          );
        },
      ),
    );
  }
}