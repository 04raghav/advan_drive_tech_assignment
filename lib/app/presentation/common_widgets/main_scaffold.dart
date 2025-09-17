import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/core/routes/route_names.dart';
import 'package:quick_order_app/app/core/utils/storage_utils.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_appbar.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const MainScaffold({
    super.key,
    required this.body,
    required this.title,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, title: title, isCenterTitle: true),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Logout',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        onTap: (index) {
          if (index == 1) {
            StorageUtils.clear();
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.login,
              (route) => false,
            );
          }
        },
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButton != null
          ? FloatingActionButtonLocation.centerDocked
          : null,
    );
  }
}
