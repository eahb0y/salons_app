import 'package:flutter/material.dart';
import 'package:salons_app/core/theme/colors/app_colors.dart';
import 'package:salons_app/core/utils/app_utils.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function(String value)? onChange;
  final Function()? onTab;
  final Widget sufficIcon;
  final Color borderColor;

  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    this.onChange,
    this.onTab,
    required this.sufficIcon,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      controller: controller,
      onTap: onTab,
      decoration: InputDecoration(
        suffixIcon: sufficIcon,
        labelText: title,
        counterText: "",
        fillColor: LightThemeColors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppUtils.kBorderRadius8,
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
