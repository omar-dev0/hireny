import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/features/view_application/domain/entities/application_entity.dart';
import 'package:hireny/features/view_application/presentation/manager/app_cubit.dart';
import 'package:hireny/features/view_application/presentation/manager/app_states.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../core/widgets/sideBar.dart';
import '../../../../routes/page_route.dart';
import '../../../my_assessment/presentation/ui/widgets/progress_card.dart';

class ViewApplication extends StatefulWidget {
  const ViewApplication({super.key});

  @override
  State<ViewApplication> createState() => _ViewApplicationState();
}

class _ViewApplicationState extends State<ViewApplication> {
  late AppCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AppCubit>();
    cubit.loadApplications();
  }

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
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    ProgressCard(icon: Icons.assignment_turned_in, title: "Completed", value: "3"),
                    ProgressCard(icon: Icons.access_time, title: "Pending", value: "2"),
                    ProgressCard(icon: Icons.check_circle, title: "Approved", value: "1"),
                    ProgressCard(icon: Icons.cancel, title: "Rejected", value: "1"),

                  ],
                ),
              ),
            ),

            // ✅ Applications List
            Expanded(
              child: BlocBuilder<AppCubit, AppStates>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ErrorState) {
                    return Center(child: Text(state.message ?? "An error occurred"));
                  } else if (state is SuccessState) {
                    return ListView.separated(
                      itemCount: cubit.applications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final app = cubit.applications[index];
                        final isPending = app.status == AppStatus.pending;
                        final isApproved = app.status == AppStatus.approved;
                        final isRejected = app.status == AppStatus.rejected;

                        final statusColor = isPending
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
                                )
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
                                        app.applicationType,
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        app.status.name,
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
                                    Icon(Icons.business_center, size: 20, color: AppColors.grey.withOpacity(0.8)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        app.companyName,
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: AppColors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                    if (isPending)
                                      InkWell(
                                        onTap: () => cubit.deleteCourse(app),
                                        borderRadius: BorderRadius.circular(30),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: AppColors.primary,
                                            size: 24,
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
                                      "Started: ${app.appliedDate}",
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: AppColors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Deadline:${app.deadlineDate}",
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
                    );
                  }
                  return const Center(child: Text('No data available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
