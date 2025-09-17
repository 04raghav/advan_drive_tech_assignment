import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order_app/app/core/constants/enums.dart';
import 'package:quick_order_app/app/data/providers/auth_provider.dart';
import 'package:quick_order_app/app/presentation/features/auth/login_screen.dart';
import 'package:quick_order_app/app/presentation/features/end_user/home/end_user_home_screen.dart';
import 'package:quick_order_app/app/presentation/features/receiver/home/receiver_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  void _checkAuth() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    } else {
      if (user.role == UserRole.endUser.name) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const EndUserHomeScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ReceiverHomeScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}