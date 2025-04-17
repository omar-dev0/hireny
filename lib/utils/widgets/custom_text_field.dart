import '../constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {


  final TextEditingController? controller;
  final bool? isPassword;
  final String? hint;
  final String? label;
  final bool? enabled;
  final TextStyle? textStyle;
  final int? maxLines, minLines, maxLength;
  final String? obscuringCharacter, value;
  final String? Function(String?)? onValidate;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget, prefixIcon;
  final IconData? icon;
  final Color? hintColor;
  final TextDirection? textDirection;
  final EdgeInsets? edgeInsets;

  const CustomTextField({
    super.key,
    this.controller,
    this.isPassword,
    this.hint,
    this.textStyle,
    this.label,
    this.enabled,
    this.obscuringCharacter,
    this.value,
    this.onValidate,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.icon,
    this.prefixIcon,
    this.textDirection,
    this.edgeInsets = const EdgeInsets.only(
      top: 14,
      left: 16,
      right: 16,
      bottom: 14,
    ),
    this.hintColor = Colors.white,
  });
  

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      controller: widget.controller,
      validator: widget.onValidate,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: widget.isPassword ?? false ? obscureText : false,
      obscuringCharacter: '*',
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      style: widget.textStyle ??
          theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.grey , fontWeight: FontWeight.w500),
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: widget.isPassword ?? false
            ? InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
        )
            : widget.suffixWidget,
        prefixIcon: widget.prefixIcon,

        hintText: widget.hint,
        hintStyle: TextStyle(
          // todo check font type
          fontFamily: "Inter",
          fontSize: 16,
          color: AppColors.grey.withOpacity(0.5),
          fontWeight: FontWeight.w400,
        ),
        counterText: "",
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),

        errorStyle: const TextStyle(
          color: AppColors.red,
          fontSize: 12,
        ),
        errorMaxLines: 6,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 1,
          ),
        ),
      ),
    );
  }
}