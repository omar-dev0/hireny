
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/extensions/font_size.dart';

class ChoiceDialog extends StatelessWidget {
  final String message;
  final String button1Text;
  final String button2Text;
  final VoidCallback onPressButton1;
  final VoidCallback onPressButton2;
  final Widget? iconButton1;
  final  Widget? iconButton2;

  const ChoiceDialog({
    required this.message,
    required this.button1Text,
    required this.button2Text,
    required this.onPressButton1,
    required this.onPressButton2,
    this.iconButton1,
    this.iconButton2,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: Duration(milliseconds: 500),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: onPressButton1,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (iconButton1 != null) iconButton1!,
                      if (iconButton1 != null) SizedBox(width: 8),
                      Text(
                        button1Text,
                        style: TextStyle(color: Colors.white, fontSize: 16.cSp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Divider(color: Colors.grey),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onPressButton2,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.primary, width: .5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (iconButton2 != null) iconButton2!,
                      if (iconButton2 != null) SizedBox(width: 8),
                      Text(button2Text),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
