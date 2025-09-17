import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order_app/app/core/routes/route_names.dart';
import 'package:quick_order_app/app/data/providers/request_provider.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_loader.dart';
import 'package:quick_order_app/app/presentation/common_widgets/main_scaffold.dart';
import 'package:quick_order_app/app/presentation/features/end_user/home/widgets/request_list_item.dart';

class EndUserHomeScreen extends StatefulWidget {
  const EndUserHomeScreen({super.key});

  @override
  State<EndUserHomeScreen> createState() => _EndUserHomeScreenState();
}

class _EndUserHomeScreenState extends State<EndUserHomeScreen> {
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
      title: 'My Requests',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, RouteNames.createRequest);
          if (mounted) {
            Provider.of<RequestProvider>(context, listen: false).fetchRequests();
          }
        },
        label: const Text('New Request'),
        icon: const Icon(Icons.add),
      ),
      body: Consumer<RequestProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingIndicator();
          }
          if (provider.requests.isEmpty) {
            return const Center(child: Text("No requests found."));
          }
          return RefreshIndicator(
            onRefresh: () => provider.fetchRequests(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: provider.requests.length,
              itemBuilder: (context, index) {
                return RequestListItem(request: provider.requests[index]);
              },
            ),
          );
        },
      ),
    );
  }
}