import 'package:flutter/material.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    this.enable = true,
    this.autoFocus = false,
    required this.controller,
    required this.validator,
    required this.keyBoardType,
    required this.hint,
    this.obscureText = false,
    required this.prefixIcon,
    this.suffixIcon,
    required this.appFontSize,
    required this.colorScheme,
  });

  final TextEditingController controller;

  // final FocusNode focusNode;
  // final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator validator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final AppFontSize appFontSize;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      autofocus: autoFocus,
      obscureText: obscureText,
      keyboardType: keyBoardType,
      controller: controller,
      validator: validator,
      cursorColor: colorScheme.onPrimary,
      style: robotoMedium.copyWith(fontSize: appFontSize.mediumFontSize),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onPrimary),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onPrimary),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onPrimary),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
