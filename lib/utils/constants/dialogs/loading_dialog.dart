import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_assets.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key});

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // makes the fade in/out repeat

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              AppAssets.hireny,
              width: 170.w,
              height: 170.h,
            ),
          ),
        ],
      ),
    );
  }
}
