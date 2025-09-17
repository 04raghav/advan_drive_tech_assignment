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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.endUser;

  Future<void> _signup() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final success = await authProvider.signup(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: _selectedRole.name,
      );
      if (success && mounted) {
        showSnackBar(
          context: context,
          title: 'Success',
          message: 'Account created successfully! Please log in.',
        );
        Navigator.of(context).pushReplacementNamed(RouteNames.login);
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
              Text("Create Account", style: AppTextStyles.heading1),
              const SizedBox(height: 8),
              Text("Get started with your new account", style: AppTextStyles.subheading),
              const SizedBox(height: 60),
              CommonTextField(hintText: 'Email', controller: _emailController),
              const SizedBox(height: 16),
              CommonTextField(hintText: 'Password', isObscure: true, controller: _passwordController),
              const SizedBox(height: 16),
              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: UserRole.values.map((UserRole role) {
                  return DropdownMenuItem<UserRole>(
                    value: role,
                    child: Text(role == UserRole.endUser ? 'End User' : 'Receiver'),
                  );
                }).toList(),
                onChanged: (UserRole? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
              ),
              const SizedBox(height: 40),
              CommonButton(text: 'Sign Up', onPressed: _signup),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(RouteNames.login);
                    },
                    child: const Text("Login"),
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