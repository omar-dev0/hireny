import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/view/widgets/related_service_card.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';

class RelatedServicesOrg extends StatelessWidget {
  static String routeName = "RelatedServicesOrg";

  const RelatedServicesOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.subPrimary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Text("Related Services", style: AppFonts.mainText),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ServiceCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
