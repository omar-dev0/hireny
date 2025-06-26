import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/widgets/salary_dialog.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:hireny/utils/widgets/custom_drop_down.dart';

import '../../../../../utils/constants/app_fonts.dart';
import 'cubit/salary_cubit.dart';

class SalaryInsightsScreenContent extends StatefulWidget {
  const SalaryInsightsScreenContent({super.key});

  @override
  State<SalaryInsightsScreenContent> createState() =>
      _SalaryInsightsScreenContentState();
}

class _SalaryInsightsScreenContentState
    extends State<SalaryInsightsScreenContent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SalaryCubit cubit = context.read<SalaryCubit>();
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
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CustomDropDown(
                  label: 'Enter a Job Title',
                  items: AppSharedData.jobs,
                  onChanged: (String? val) {
                    cubit.jobTitle = val;
                  },
                ),
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 700),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CustomDropDown(
                  label: 'Enter experience level ',
                  items: AppSharedData.careerLevels,
                  onChanged: (String? val) {
                    cubit.experience = val;
                  },
                ),
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 700),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CustomDropDown(
                  label: 'Enter job location',
                  items: AppSharedData.countries,
                  onChanged: (String? val) {
                    cubit.location = val;
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: CustomButtom(
                title: "Search",
                onPressed: () async {
                  if (!cubit.checkValidation()) {
                    Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      msg: 'please fill all fields',
                    );
                  } else {
                    await cubit.findGoodSalary();
                  }
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
