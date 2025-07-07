import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/job_detailes_state.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';

import '../cubit/job_detailes_cubit.dart';
import 'icon_element.dart';

class RelatedJobs extends StatelessWidget {
  final int jobId;
  final JobDetailsCubit cubit;
  const RelatedJobs({super.key, required this.jobId, required this.cubit});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getRelatedJobs(jobId),
      child: BlocBuilder<JobDetailsCubit, JobDatailesState>(
        builder: (context, state) {
          if (state is LoadRelatedJobs) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is RelatedJobsError) {
            return Center(child: Text(state.message));
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    itemCount: cubit.relatedJobs.length,
                    itemBuilder: (context, index) {
                      final job = cubit.relatedJobs[index];
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
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  job.deadline,
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Image.network(
                                    job.companyLogo.startsWith('/media')
                                        ? 'http://localhost:8000${job.companyLogo}'
                                        : job.companyLogo,
                                    width:
                                        MediaQuery.sizeOf(context).width * .2,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.jobTitle,
                                          style: AppFonts.mainText.copyWith(
                                            fontSize: 17,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          job.companyName,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconElement(
                                    icon: Icon(
                                      Icons.timer,
                                      color: AppColors.primary,
                                    ),
                                    label: job.jobType,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconElement(
                                    icon: Icon(
                                      Icons.account_balance_wallet_rounded,
                                      color: AppColors.primary,
                                    ),
                                    label:
                                        '${job.minSalary} - ${job.maxSalary} ${job.currency}',
                                  ),
                                  IconElement(
                                    icon: Icon(
                                      Icons.location_on_rounded,
                                      color: AppColors.primary,
                                    ),
                                    label: job.country,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
