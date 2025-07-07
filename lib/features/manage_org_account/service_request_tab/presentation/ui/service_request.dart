import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import 'package:intl/intl.dart';
import '../../../../../routes/page_route.dart';
import '../../../../../utils/constants/app_colors.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';

import '../manager/service_applications_cubit.dart';
import '../manager/service_applications_states.dart';

class ServiceRequest extends StatelessWidget {
  const ServiceRequest({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ServiceApplicationsCubit>();

    return BlocBuilder<ServiceApplicationsCubit, ServiceApplicationsStates>(
      builder: (context, state) {
        final applications = AppSharedData.serviceApplications;

        return CustomScreen(
          title: "Service Request",
          drawer: const SideBarScreen(currentRoute: PagesRoute.orgServiceRequest),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manage Service Requests (${applications.length})",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                if (state is LoadingState)
                  const Center(child: CircularProgressIndicator())
                else if (applications.isEmpty)
                  const Center(child: Text("No applications available."))
                else
                  Expanded(
                    child: GridView.builder(
                      itemCount: applications.length,
                      padding: const EdgeInsets.only(bottom: 12),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 350,
                        mainAxisExtent: 140,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final app = applications[index];
                        final post = app.servicePost;
                        final formattedDate =
                        cubit.getFormattedDateOnly("${app.createdAt}");

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.subPrimary,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.primary),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      post?.title ?? "No title",
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cubit.deleteApplication(app.id);
                                    },
                                    icon: const Icon(Icons.delete_outline, color: AppColors.red),
                                    tooltip: "Delete",
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(Icons.attach_money, size: 16, color: AppColors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${post?.salary ?? '0'} ${post?.currency.firstOrNull ?? ''}",
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "Requested at: $formattedDate",
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: AppColors.grey,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
