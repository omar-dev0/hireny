import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';

class SalaryDialog extends StatelessWidget {
  final String? message;
  final String? positiveButtonText;
  final VoidCallback? onPositivePressed;
  final String? negativeButtonText;
  final VoidCallback? onNegativePressed;

  const SalaryDialog({
    this.message,
    this.positiveButtonText,
    this.onPositivePressed,
    this.negativeButtonText,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: Duration(milliseconds: 600),
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              AppAssets.moneyAnimation,
              width: 150.w,
              height: 150.h,
              repeat: true,
            ),
            if (message != null) SizedBox(height: 20),
            if (message != null)
              Text(
                message!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
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
                        backgroundColor: Colors.redAccent,
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
                        backgroundColor: Colors.green,
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
