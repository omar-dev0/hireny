import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';

import '../../../utils/constants/app_fonts.dart';
import '../../../utils/widgets/search_bar_widget.dart';
import '../../../views/salary_insights/salary_insights_screen.dart';
import '../../organization/view/explore_organizations_org.dart';
import 'explore_courses_seeker.dart';
import 'explore_job_seeker.dart';

class HomePageSeeker extends StatelessWidget {
  static String routeName = "HomePageSeeker";

  const HomePageSeeker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.subPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.h,),
          Text("Job  Seeker",style: AppFonts.mainText,),
          TabBar(
              isScrollable: true,
              indicatorColor: Colors.black,
              tabs: [
                Tab(child: Text("Home"),),
                Tab(child: Text("Find Job"),),
                Tab(child: Text("Organizations"),),
                Tab(child: Text("Courses"),),
                Tab(child: Text("Salary Insights"),),
              ]
          ),
          Expanded(child: TabBarView(
              children: [

              ])
          )
        ],
      ),
    );
  }
}
