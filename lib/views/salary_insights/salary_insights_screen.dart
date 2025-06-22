import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInDown(
              duration: Duration(milliseconds: 500),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Find The Best Salaries in Your Field",
                      style: AppFonts.mainText,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Explore detailed salary data by job title, location, and experience to see",
                      style: AppFonts.secMain,
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      AppAssets.salary_insights,
                      width: size.width * .6,
                      height: size.height * .25,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            FadeIn(
              duration: Duration(milliseconds: 600),
              child: Text("Salary insights", style: AppFonts.mainText),
            ),
            SizedBox(height: 16.h),

            FadeInUp(
              duration: Duration(milliseconds: 700),
              child: DropDownListCustom(
                hintText: "Enter a Job Title",
                iconData: Icons.search,
                items: ["Software Engineer", "Tester"],
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 800),
              child: DropDownListCustom(
                hintText: "Enter a Job Location",
                iconData: Icons.location_on,
                items: ["Egypt", "Tunisia"],
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 900),
              child: DropDownListCustom(
                hintText: "The Num of Years of Experience",
                iconData: Icons.date_range,
                items: ["1", "2", "3", "4", "5"],
              ),
            ),
            SizedBox(height: 20.h),
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: CustomButtom(
                title: "Search",
                onPressed: () {
                  print("pressed");
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
