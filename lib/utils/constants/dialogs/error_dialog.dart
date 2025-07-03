import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/utils/extensions/font_size.dart';
import 'package:lottie/lottie.dart';
import 'package:hireny/utils/app_assets.dart'; // Ensure this contains `errorAnimation`

class ErrorDialog extends StatelessWidget {
  final String? message;
  final String? positiveButtonText;
  final VoidCallback? onPositivePressed;
  final String? negativeButtonText;
  final VoidCallback? onNegativePressed;

  const ErrorDialog({
    this.message,
    this.positiveButtonText,
    this.onPositivePressed,
    this.negativeButtonText,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      duration: Duration(milliseconds: 600),
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              AppAssets
                  .errorAnimation, // <-- Make sure this exists in your assets
              width: 90.w,
              height: 90.h,
              repeat: false,
            ),
            if (message != null) SizedBox(height: 20),
            if (message != null)
              Text(
                message!,
                style: TextStyle(
                  fontSize: 18.cSp,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
            if (message != null) SizedBox(height: 30),
            Row(
              children: [
                if (negativeButtonText != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onNegativePressed?.call,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(negativeButtonText!),
                    ),
                  ),
                if (negativeButtonText != null) SizedBox(width: 10),
                if (positiveButtonText != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPositivePressed?.call,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(positiveButtonText!),
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
