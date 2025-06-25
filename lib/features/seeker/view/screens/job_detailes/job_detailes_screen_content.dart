import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/icon_element.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/job_description_section.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/related_jobs.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/required_skills.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/reuierment.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/extensions/font_size.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

import '../../../../../utils/constants/app_fonts.dart';

class JobDetailesContent extends StatelessWidget {
  const JobDetailesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            AppAssets.google,
                            width: MediaQuery.sizeOf(context).width * .2,
                            height: MediaQuery.sizeOf(context).height * .1,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Flutter Developer',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppFonts.mainText.copyWith(
                                  fontSize: 20.sp,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Text(
                                    'Google Group',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13.cSp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Icon(
                                    Icons.public,
                                    color: AppColors.primary,
                                    size: 15.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      '10 min ago',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconElement(
                            icon: Icon(
                              Icons.wallet_travel_rounded,
                              color: AppColors.primary,
                            ),
                            label: 'Software - Programming',
                          ),
                          IconElement(
                            icon: Icon(Icons.timer, color: AppColors.primary),
                            label: 'Full Time',
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconElement(
                            icon: Icon(
                              Icons.account_balance_wallet_rounded,
                              color: AppColors.primary,
                            ),
                            label: '4000 - 5000 \$',
                          ),
                          IconElement(
                            icon: Icon(
                              Icons.location_on_rounded,
                              color: AppColors.primary,
                            ),
                            label: 'New-York, USA',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 150.w,
                      height: 40.h,
                      child: CustomButtom(title: 'Apply Job', onPressed: () {}),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                TabBar(
                  isScrollable: true,
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Padding(padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Job Description',
                        style: TextStyle(fontSize: 13),
                      ),
                    )),

                    Padding(padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Requirements',
                        style: TextStyle(fontSize: 13),
                      ),
                    )),
                    Padding(padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Required Skills',
                        style: TextStyle(fontSize: 13),
                      ),
                    )),
                    Padding(padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Related Jobs',
                        style: TextStyle(fontSize: 13),
                      ),
                    )),

                  ],
                ),
                Expanded(
                    child: TabBarView(
                        children: [
                          JobDesc(),
                          Requerment(),
                          RequiredSkills(),
                          RelatedJobs(),
                        ]
                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
