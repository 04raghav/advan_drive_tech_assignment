import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final TextEditingController? controller;
  final IconData? prefixIcon;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.isObscure = false,
    this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.subheading,
        filled: true,
        fillColor: AppColors.textFieldBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.textSecondary) : null,
      ),
    );
  }
}