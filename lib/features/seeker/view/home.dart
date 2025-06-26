import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/seeker/view/screens/explore_job/cubit/explore_job_cubit.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/widgets/job_explore_card.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/widgets/custom_search_bar.dart';
import '../domain/modules/job_post.dart';

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

          //👇 Animated Search Field
          SliverToBoxAdapter(
            child: FadeInDown(
              duration: Duration(milliseconds: 500),
              child: CustomSearchBar(
                hintText: "Search for Jobs",
                onSearchChanged: (value) {
                  // Trigger filtering in Cubit
                  context.read<JobPostCubit>().filterJobPosts(value);
                },
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
                      jobPost: JobPost(
                        id: 1,
                        jobTitle: "Software Engineer",
                        minSalary: "3000.00",
                        maxSalary: "5000.00",
                        jobDescription: "We are looking for a skilled Software Engineer to join our team. You will be responsible for developing and maintaining internal tools and systems.",
                        jobRequirements: "Bachelor's degree in Computer Science or related field. Experience with Flutter and REST APIs is a plus.",
                        educationLevel: "Bachelor's Degree",
                        deadline: "2025-07-15T23:59:59Z",
                        country: "Egypt",
                        city: "Cairo",
                        category: ["Information Technology", "Software Development"],
                        currency: "USD",
                        companyName: "Tech Solutions Inc.",
                        companyLogo: "https://example.com/company-logo.png",
                        totalApplications: 45,
                        createdAt: "2025-06-24T18:54:45.818426Z",
                        jobType: "Full-time",
                      ),
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
