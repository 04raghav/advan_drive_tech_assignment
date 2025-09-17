import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order_app/app/core/constants/enums.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';
import 'package:quick_order_app/app/core/routes/route_names.dart';
import 'package:quick_order_app/app/core/utils/common_snackbar.dart';
import 'package:quick_order_app/app/data/providers/auth_provider.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_button.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_loader.dart';
import 'package:quick_order_app/app/presentation/common_widgets/common_textfield.dart';
import 'package:quick_order_app/app/presentation/features/end_user/home/end_user_home_screen.dart';
import 'package:quick_order_app/app/presentation/features/receiver/home/receiver_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _login() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final success = await authProvider.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (success && mounted) {
        showSnackBar(
          context: context,
          title: 'Success',
          message: 'Logged in successfully!',
        );
        if (authProvider.user?.role == UserRole.endUser.name) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const EndUserHomeScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ReceiverHomeScreen()),
          );
        }
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return provider.isLoading
                ? const LoadingIndicator()
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: child,
                  );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Text("Quick Order", style: AppTextStyles.heading1),
              const SizedBox(height: 8),
              Text(
                "Your personal shopping assistant",
                style: AppTextStyles.subheading,
              ),
              const SizedBox(height: 60),
              CommonTextField(hintText: 'Email', controller: _emailController),
              const SizedBox(height: 16),
              CommonTextField(
                hintText: 'Password',
                isObscure: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 40),
              CommonButton(text: 'Login', onPressed: _login),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(RouteNames.signup);
                    },
                    child: const Text("Sign Up"),
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
