import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/widgets/job_explore_card.dart';

import '../../../utils/constants/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Seeker seeker;

  @override
  void initState() {
    super.initState();
    if (AppSharedData.user is Seeker) {
      seeker = AppSharedData.user as Seeker;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FadeInUp(
              child: Image.asset(
                'assets/images/main_screen.png',
                width: MediaQuery.sizeOf(context).width * 0.8,
                height: MediaQuery.sizeOf(context).height * 0.2,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // 👇 Animated Search Field
          SliverToBoxAdapter(
            child: FadeInDown(
              duration: Duration(milliseconds: 500),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for jobs...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(Icons.search, color: AppColors.primary),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // Implement search logic here
                  },
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          SliverToBoxAdapter(
            child: Text(
              'Featured Jobs',
              textAlign: TextAlign.center,
              style: AppFonts.mainText,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          SliverToBoxAdapter(
            child: Text(
              'Choose jobs from the top employers and apply for the same.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // 👇 Animated Job Cards
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return FadeInUp(
                delay: Duration(milliseconds: 100 * index),
                duration: Duration(milliseconds: 600),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: InkWell(
                    onTap: () {},
                    child: JobExploreCard(
                      title: 'Google',
                      jobType: 'Part Time',
                      salary: '2000\$',
                      companyName: 'Google',
                      logoImage: AppAssets.google,
                      location: 'Egypt',
                      applicantsCount: '30',
                      deadline: '20/20/2020',
                    ),
                  ),
                ),
              );
            }, childCount: 10),
          ),
        ],
      ),
    );
  }
}
