import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/view/widgets/service_details_description.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/extensions/font_size.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

class ServiceDetailsOrg extends StatelessWidget {

  const ServiceDetailsOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.subPrimary,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h,),
              Text("Service Details",style: AppFonts.mainText,),
              Text("Explore detailed job descriptions, required skills.json, and application steps to find your perfect fit.",style: AppFonts.secMain,),
              SizedBox(height: 25.h,),
              Row(
                children: [
                  Image.asset(AppAssets.org_logo,width: 40.w,height: 40.h,),
                  SizedBox(width: 10.w,),
                  Text("Corporate Solutions Executive",style: AppFonts.mainText.copyWith(fontSize: 20.cSp),)
                ],
              ),
              SizedBox(height: 15.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ImageIcon(AssetImage(AppAssets.briefcase_logo)),
                  Text("Commerce - Marketing"),
                  ImageIcon(AssetImage(AppAssets.wallet_logo)),
                  Text("40000 dollar"),
                ],
              ),
              SizedBox(height: 15.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(AssetImage(AppAssets.location_logo)),
                  SizedBox(width: 10.w,),
                  Text("New-York, USA"),
                ],
              ),
              SizedBox(height: 15.h,),
              CustomButtom(title: "Request", onPressed: (){}),
              SizedBox(height: 15.h,),
              ServiceDetailsDescription(),
              InkWell(
                onTap: (){
                  //navigate to related services
                },
                  child: Text("Show related services",style: AppFonts.secMain.copyWith(decoration: TextDecoration.underline),textAlign: TextAlign.center,))
            ],
          ),
        ),
      ),
    );
  }
}
