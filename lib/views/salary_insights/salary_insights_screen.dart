import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:hireny/utils/widgets/custom_get_started.dart';
import 'package:hireny/utils/widgets/drop_down_list_custom.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_fonts.dart';

class SalaryInsightsScreen extends StatefulWidget {

  const SalaryInsightsScreen({super.key});

  @override
  State<SalaryInsightsScreen> createState() => _SalaryInsightsScreenState();
}

class _SalaryInsightsScreenState extends State<SalaryInsightsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 30.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppAssets.logo,
                width: 110.w,
                height: 40.h,
              ),
              Row(
                children: [
                  CustomGetStarted(),
                  Icon(Icons.menu, color: AppColors.primary),
                ],
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 350.h,
              color: AppColors.subPrimary,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Find The Best Salaries in Your Field",style: AppFonts.mainText,textAlign: TextAlign.center,),
                    Text("Explore detailed salary data by job title, location, and experience to see",style: AppFonts.secMain,textAlign: TextAlign.center),
                    Image.asset(AppAssets.salary_insights)
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h,),
            Text("Salary insights",style: AppFonts.mainText,),
            SizedBox(height: 16.h,),
            DropDownListCustom(hintText: "Enter a Job Title",iconData: Icons.search,items: ["Software Engineer", "Tester"], ),
            DropDownListCustom(hintText: "Enter a Job Location",iconData:  Icons.location_on, items: ["Egypt", "Tunisia"],),
            DropDownListCustom(hintText: "The Num of Years of Experience",iconData: Icons.date_range,items: ["1", "2", "3", "4", "5"],),
            CustomButtom(title: "Search",onPressed: (){print("pressed");},),
            SizedBox(height: 20.h,),

          ],
        ),
      ),
    );
  }
}
