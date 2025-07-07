import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/auth/domain/modules/assessment/assessment.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/job_detailes_cubit.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/job_description_section.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/related_jobs.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/required_skills.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/widgets/reuierment.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/extensions/font_size.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/data_shared/shared_const_api.dart';
import '../../../../seeker/view/screens/job_detailes/widgets/icon_element.dart';
import '../../../domain/modules/job_details.dart';
import 'application_deatailes/application_detailes_screen.dart';

class JobDetailesContent extends StatelessWidget {
  final JobDetailsModel? job;

  const JobDetailesContent({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    JobDetailsCubit jobDetailsCubit = context.read<JobDetailsCubit>();
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

                          child: Image.network(
                            '${ApiShared.baseUrl}${job?.companyLogo}',
                            width: MediaQuery.sizeOf(context).width * .2,
                            height: MediaQuery.sizeOf(context).height * .1,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Image.asset(
                                AppAssets.org_logo,
                              ); // Fallback to placeholder if image fails to load
                            },
                          ),
                          // Image.asset(
                          //   //url : ${ApiShared.baseurl}${job.companyLogo}
                          //   AppAssets.org_logo,
                          //   width: MediaQuery.sizeOf(context).width * .2,
                          //   height: MediaQuery.sizeOf(context).height * .1,
                          // ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job?.jobTitle ?? "",
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
                                    job?.companyName ?? "null",
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
                            label: job?.category.join(", ") ?? "null",
                          ),
                          IconElement(
                            icon: Icon(Icons.timer, color: AppColors.primary),
                            label: job?.jobType ?? "null",
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
                            label:
                                '${job?.minSalary} - ${job?.maxSalary} ${job?.currency}',
                          ),
                          IconElement(
                            icon: Icon(
                              Icons.location_on_rounded,
                              color: AppColors.primary,
                            ),
                            label: '${job?.country}',
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
                      child: CustomButtom(
                        title: 'Apply Job',
                        onPressed: () {
                          if (job?.questions == null ||
                              job?.questions.isEmpty == true) {
                            jobDetailsCubit.applyJob(job?.id ?? 0, false);
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ApplicationDetailesScreen(
                                    applicationModel: AssessmentModel(
                                      assessmentTitle: job?.jobTitle,
                                      id: job?.id,
                                      questions: job?.questions,
                                    ),
                                  ),
                            ),
                          );
                        },
                      ),
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
                    _buildTab("Job Description"),
                    _buildTab("Requirements"),
                    _buildTab("Required Skills"),
                    _buildTab("Related Jobs"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      JobDesc(description: job?.jobDescription ?? "null"),
                      Requerment(requirements: job?.jobRequirements ?? "null"),
                      RequiredSkills(skills: job?.requiredSkills ?? []),
                      RelatedJobs(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(title, style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
