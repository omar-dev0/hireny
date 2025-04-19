import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/app_fonts.dart';
import 'package:hireny/utils/extensions/font_size.dart';

class ErrorScreen extends StatelessWidget {
  static String routeName = "ErrorScreen";
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("ERROR",style: AppFonts.secMain,textAlign: TextAlign.center,),
            SizedBox(height: 12.h,),
            Image.asset(AppAssets.error),
            SizedBox(height: 30.h,),
            Text("Oops... Something went wrong",style: AppFonts.mainText, textAlign: TextAlign.center,),
            Text("An error has occurred. Please try again or return to the home page.",style: AppFonts.secMain.copyWith(fontSize: 20.cSp), textAlign: TextAlign.center,),

          ],
        ),
      ),
    );
  }
}
