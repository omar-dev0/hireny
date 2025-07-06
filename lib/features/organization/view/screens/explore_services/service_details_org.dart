import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/extensions/font_size.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import '../../../../../utils/constants/dialogs/success_dialog.dart';
import '../../../../../utils/data_shared/shared_const_api.dart';
import '../../../domain/modules/service.dart';
import 'cubit/explore_services_cubit.dart';
import 'cubit/explore_services_states.dart';

class ServiceDetailsOrg extends StatelessWidget {
  final ServiceModel service;
  final ExploreServicesCubit cubit;

  const ServiceDetailsOrg({
    super.key,
    required this.service,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Service Details", style: AppFonts.mainText),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Logo + Name + Title
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.network(
                          '${ApiShared.baseUrl}${service.companyLogo}',
                          width: 60.w,
                          height: 60.h,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Image.asset(
                                AppAssets.org_logo,
                                width: 60.w,
                                height: 60.h,
                              ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.companyName ?? "Company Name",
                              style: AppFonts.mainText.copyWith(
                                fontSize: 18.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              service.serviceTitle ?? "Service Title",
                              style: AppFonts.secMain.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Description
                  Text(
                    "Description",
                    style: AppFonts.mainText.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    service.serviceDescription ?? "No description provided.",
                    style: AppFonts.textFieldStyle,
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: 16.h),

                  // Category Chips
                  if (service.category?.isNotEmpty == true)
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 4.h,
                      children:
                          service.category!
                              .map(
                                (cat) => Chip(
                                  label: Text(
                                    cat,
                                    style: AppFonts.textFieldStyle.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  backgroundColor: AppColors.primary
                                      .withOpacity(0.1),
                                ),
                              )
                              .toList(),
                    ),

                  SizedBox(height: 16.h),

                  // Salary & Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${service.salary} ${service.currency?.first ?? ""}",
                        style: AppFonts.mainText.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${service.country}, ${service.city}",
                          style: AppFonts.secMain.copyWith(fontSize: 14.cSp),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Availability Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Availability:", style: AppFonts.secMain),
                      Chip(
                        label: Text(
                          service.serviceAvailable ?? "Unknown",
                          style: AppFonts.textFieldStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor:
                            service.serviceAvailable == "available"
                                ? Colors.green
                                : Colors.orange,
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Total Applications
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Applications:", style: AppFonts.secMain),
                      Text(
                        "${service.totalApplications ?? 0}",
                        style: AppFonts.mainText.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            BlocListener<ExploreServicesCubit, ExploreServicesState>(
              listener: (context, state) {
                if (state is ExploreServicesLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => LoadingDialog(),
                  );
                }
                if (state is HideServiceDialog) {
                  Navigator.pop(context);
                }
                if (state is ServiceAppliedSuccess) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => SuccessDialog(message: state.message),
                  );
                }

                if (state is ServiceAppliedFailed) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => ErrorDialog(message: state.message),
                  );
                }
              },
              child: CustomButtom(
                title: "Request",
                onPressed: () {
                  BlocProvider.of<ExploreServicesCubit>(
                    context,
                  ).applyToService(service.id!);
                },
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
