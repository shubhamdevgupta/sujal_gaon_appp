import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final IconData? icon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool enabled;
  final void Function(String)? onChanged;

  /// 🔥 Allow full decoration override
  final InputDecoration? decoration;

  const AppTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.icon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
    this.onChanged,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = InputDecoration(
      prefixIcon:
      icon != null ? Icon(icon, color: Colors.blueGrey) : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF5F7FA),
      hintText: hint,
      labelText: label,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
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
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
      ),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      enabled: enabled,
      onChanged: onChanged,
      decoration: decoration ?? defaultDecoration,
    );
  }
}