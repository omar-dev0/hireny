import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/admin/view/widgets/org_description_card.dart';
import 'package:hireny/features/admin/view/widgets/org_info_card.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

class VerifyOrganizationAdmin extends StatelessWidget {
  static String routeName = "VerifyOrganizationAdmin";

  const VerifyOrganizationAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.subPrimary,
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(AppAssets.org_logo,
                    fit: BoxFit.fill, // Optional
                    width: 50.w,
                    height: 50.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Corporate Solutions",style: AppFonts.mainText,),
                      Text("Joining Date : 01/02/2025",style: AppFonts.secMain,),
          
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      //navigate to chat hnaa
                    },
                      child: ImageIcon(AssetImage( AppAssets.chat_icon,),)),              ],
              ),
              SizedBox(height: 20.h,),
              OrganizationInfoCard(
                ceoName: "John Smith",
                size: "2000",
                industry: "Commerce",
                established_Year: "1995",
                Location: "New York, USA",
                Phone: "+1234567890",
                Email: "corporatesolutions@gmail.com",
              ),
              OrganizationDescriptionCard(),
              Text("Proof of company",style: AppFonts.mainText,),
              Text("Download Proof of company as PDF",style: AppFonts.secMain.copyWith(decoration: TextDecoration.underline,),),
              SizedBox(height: 20.h,),
              CustomButtom(title: "Reject", onPressed: (){}),
              SizedBox(height: 10.h,),
              CustomButtom(title: "Approve", onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}
