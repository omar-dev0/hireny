import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/extensions/font_size.dart';

import '../../../../utils/constants/app_fonts.dart';

class ThankYouScreen extends StatelessWidget {

  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.thank_you),
            SizedBox(height: 30.h,),
            Text("Thank You",style: AppFonts.mainText, textAlign: TextAlign.center,),
            SizedBox(height: 30.h,),
            Text("We have received your message. An expert will get back to you shortly",style: AppFonts.hintStyle, textAlign: TextAlign.center,),

          ],
        ),
      ),
    );
  }
}
