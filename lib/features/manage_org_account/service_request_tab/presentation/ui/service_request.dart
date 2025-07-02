import 'package:flutter/material.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../../../../routes/page_route.dart';
import '../../../../../utils/constants/app_colors.dart';

class ServiceRequest extends StatelessWidget {
  const ServiceRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScreen(
      title: "Service Request",
      drawer: const SideBarScreen(currentRoute: PagesRoute.orgServiceRequest),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Page Title
            Text(
              "Manage Service Requests (0)",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            /// Grid of Requests
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                padding: const EdgeInsets.only(bottom: 12),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350,
                  mainAxisExtent: 140,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
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
                        /// Top Row: Title + Delete
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Logo Design",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // TODO: delete action
                              },
                              icon: const Icon(Icons.delete_outline, color: AppColors.red),
                              tooltip: "Delete",
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// Price Info
                        Row(
                          children: [
                            Icon(Icons.attach_money, size: 16, color: AppColors.grey),
                            const SizedBox(width: 4),
                            Text(
                              "2 EGP",
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// Requested Date
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "Requested at: July 22, 2002, 12:12 AM",
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
  }
}
