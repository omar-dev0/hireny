import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';

import 'icon_element.dart';

class RelatedJobs extends StatelessWidget {
  const RelatedJobs({super.key});

  final List<Map<String, dynamic>> jobs = const [
    {
      'time': '25 min',
      'title': 'Content Creator',
      'company': 'Google Group',
      'industry': 'Commerce',
      'type': 'Full Time',
      'salary': '3000 - 4000 \$',
      'location': 'Egypt',
      'logo': 'assets/images/youtube.png',
    },
    {
      'time': '1 hour',
      'title': 'UI/UX Designer',
      'company': 'Meta Inc.',
      'industry': 'Design',
      'type': 'Part Time',
      'salary': '2500 - 3500 \$',
      'location': 'Remote',
      'logo': 'assets/images/youtube.png',
    },
    {
      'time': '3 hours',
      'title': 'Flutter Developer',
      'company': 'Amazon Dev',
      'industry': 'IT',
      'type': 'Full Time',
      'salary': '4000 - 6000 \$',
      'location': 'New York, USA',
      'logo': 'assets/images/youtube.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return FadeInUp(
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: index * 150),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.subPrimary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            job['time'],
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Image.asset(
                              job['logo'],
                              width: MediaQuery.sizeOf(context).width * .2,
                              height: MediaQuery.sizeOf(context).height * .07,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job['title'],
                                    style: AppFonts.mainText.copyWith(fontSize: 17),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    job['company'],
                                    style: TextStyle(color: Colors.grey, fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconElement(
                              icon: Icon(Icons.wallet_travel_rounded, color: AppColors.primary),
                              label: job['industry'],
                            ),
                            IconElement(
                              icon: Icon(Icons.timer, color: AppColors.primary),
                              label: job['type'],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconElement(
                              icon: Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary),
                              label: job['salary'],
                            ),
                            IconElement(
                              icon: Icon(Icons.location_on_rounded, color: AppColors.primary),
                              label: job['location'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
