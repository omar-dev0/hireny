import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_fonts.dart';
import 'package:hireny/utils/extensions/theme_extinsion.dart';

class AppButton extends StatelessWidget {
  final void Function() onPress;
  final String text;
  const AppButton({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: context.appColors.primary,
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))
      ),
      onPressed: onPress,
      child: Text(text, style: AppFonts.buttonTextStyle),
    );
  }
}
