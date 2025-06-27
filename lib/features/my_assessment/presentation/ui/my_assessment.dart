import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/my_assessment/presentation/ui/widgets/progress_card.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../routes/page_route.dart';

class MyAssessment extends StatelessWidget {
  const MyAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScreen(
      title: "My Assessments",
      drawer: const SideBarScreen(currentRoute: PagesRoute.myAssessment),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with stats
            FadeInDown(
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                  children: [
                    ProgressCard(
                      icon: Icons.assignment_turned_in,
                      title: "Completed", value: "3" ),
                    ProgressCard(
                        icon: Icons.access_time,
                        title: "Pending", value: "3" ),
                    ProgressCard(
                        icon: Icons.cancel,
                        title: "Not Started", value: "3" ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Assessments List
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return FadeInUp(
                    duration: Duration(milliseconds: 300 + index * 100),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.subPrimary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1,
                        ),
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
                          // Header Row
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.assignment, color: AppColors.primary),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Flutter Developer Assessment",
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(index),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            _getStatusText(index),
                                            style: theme.textTheme.labelSmall?.copyWith(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Technical Screening",
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: AppColors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Info Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.business_center, size: 16, color: AppColors.grey),
                                  const SizedBox(width: 4),
                                  Text("Google", style: theme.textTheme.bodySmall),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.timer, size: 16, color: AppColors.grey),
                                  const SizedBox(width: 4),
                                  Text("20 min", style: theme.textTheme.bodySmall),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.score, size: 16, color: AppColors.grey),
                                  const SizedBox(width: 4),
                                  Text("${_getScore(index)}/15", style: theme.textTheme.bodySmall),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Started: 12 Oct 2022", style: theme.textTheme.bodySmall),
                              Text("Completed: 12 Oct 2022", style: theme.textTheme.bodySmall),
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


  Color _getStatusColor(int index) {
    switch (index % 3) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  String _getStatusText(int index) {
    switch (index % 3) {
      case 0:
        return "Completed";
      case 1:
        return "Pending";
      default:
        return "Not Started";
    }
  }

  String _getScore(int index) {
    switch (index % 3) {
      case 0:
        return "12";
      case 1:
        return "-";
      default:
        return "0";
    }
  }
}
