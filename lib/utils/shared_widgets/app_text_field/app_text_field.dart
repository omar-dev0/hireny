import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_fonts.dart';
import 'package:hireny/utils/extensions/theme_extinsion.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  const AppTextField({
    super.key,
    required this.controller,
    this.keyboard = TextInputType.text,
    required this.hintText,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool isScure;
  String buttonShow = 'Show';
  @override
  void initState() {
    super.initState();
    isScure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: context.appColors.primary,
      style: AppFonts.textFieldStyle,
      keyboardType: widget.keyboard,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: isScure,
      inputFormatters:
          widget.keyboard == TextInputType.phone ||
                  widget.keyboard == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: context.appColors.onPrimaryContainer),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: context.appColors.onPrimaryContainer),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: context.appColors.onPrimaryContainer),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: context.appColors.onPrimaryContainer),
        ),
        suffixIcon: widget.isPassword ? TextButton(
          onPressed: () {
            setState(() {
              isScure = !isScure;
              if(isScure)
                {
                  buttonShow = 'Show';
                }
              else
                {
                  buttonShow = 'Hide';
                }
            });
          },
          child: Text(
            buttonShow,
            style: AppFonts.textFieldStyle.copyWith(
              color: context.appColors.primary,
            ),
          ),
        ) : null,
      ),
    );
  }
}
