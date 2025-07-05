import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/view_application/domain/model/user_application.dart';

import '../../../../core/widgets/sideBar.dart';
import '../../../../routes/page_route.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/widgets/custome_appbar_drawer.dart';
import '../../../my_assessment/presentation/ui/widgets/progress_card.dart';
import '../manager/app_cubit.dart';

class ViewApplicationContent extends StatelessWidget {
  final List<SeekerApplication> applications;
  final int pending;
  final int rejected;
  final int approved;
  final int completed;
  const ViewApplicationContent({
    super.key,
    required this.applications,
    required this.pending,
    required this.rejected,
    required this.approved,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScreen(
      title: "My Applications",
      drawer: const SideBarScreen(currentRoute: PagesRoute.myApplication),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ✅ Header Summary Stats
            FadeInDown(
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    ProgressCard(
                      icon: Icons.assignment_turned_in,
                      title: "Completed",
                      value: "3",
                    ),
                    ProgressCard(
                      icon: Icons.access_time,
                      title: "Pending",
                      value: "2",
                    ),
                    ProgressCard(
                      icon: Icons.check_circle,
                      title: "Approved",
                      value: "1",
                    ),
                    ProgressCard(
                      icon: Icons.cancel,
                      title: "Rejected",
                      value: "1",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: applications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final app = applications[index];
                  bool isPending = app.status?.toLowerCase() == 'pending';
                  bool isRejected = app.status?.toLowerCase() == 'rejected';
                  bool isApproved = app.status?.toLowerCase() == 'approved';
                  final statusColor =
                      isPending
                          ? AppColors.grey.withOpacity(0.7)
                          : isRejected
                          ? AppColors.red
                          : isApproved
                          ? AppColors.green
                          : AppColors.primary;

                  return FadeInUp(
                    duration: Duration(milliseconds: 300 + index * 100),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.subPrimary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primary, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Application Type + Status
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  app.jobPost?.title ?? "",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  app.status ?? "",
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Company + Delete
                          Row(
                            children: [
                              Icon(
                                Icons.business_center,
                                size: 20,
                                color: AppColors.grey.withOpacity(0.8),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  app.jobPost?.companyName ?? "",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.black.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Dates
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Started: ${app.createdAt?.year}/${app.createdAt?.month}/${app.createdAt?.day}",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.grey.withOpacity(0.8),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Deadline:${app.jobPost?.deadline?.year}/${app.jobPost?.deadline?.month}/${app.jobPost?.deadline?.day}",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.grey.withOpacity(0.8),
                                ),
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
      ),
    );
  }
}
