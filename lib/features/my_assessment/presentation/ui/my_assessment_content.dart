import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/auth/domain/modules/assessment/assessment.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/assissment_details_screen.dart';
import 'package:hireny/features/my_assessment/presentation/ui/widgets/progress_card.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../routes/page_route.dart';

class MyAssessmentContent extends StatelessWidget {
  const MyAssessmentContent({
    super.key,
    required this.assessments,
    required this.completed,
    required this.missing,
    required this.pandding,
  });
  final List<AssessmentModel> assessments;
  final int missing;
  final int completed;
  final int pandding;
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
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProgressCard(
                      icon: Icons.assignment_turned_in,
                      title: "Completed",
                      value: "$completed",
                    ),
                    ProgressCard(
                      icon: Icons.access_time,
                      title: "Pending",
                      value: "$pandding",
                    ),
                    ProgressCard(
                      icon: Icons.cancel,
                      title: "Missing",
                      value: "$missing",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Assessments List
            assessments.isEmpty
                ? Center(child: Text('not assessment found for this user'))
                : Expanded(
                  child: ListView.separated(
                    itemCount: assessments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return FadeInUp(
                        duration: Duration(milliseconds: 300 + index * 100),
                        child: InkWell(
                          onTap: () {
                            final now = DateTime.now();
                            final start =
                                assessments[index].assessmentStartTime!;
                            final end = assessments[index].assessmentEndTime!;

                            if ((now.isAtSameMomentAs(start) ||
                                    now.isAfter(start)) &&
                                (now.isAtSameMomentAs(end) ||
                                    now.isBefore(end))) {
                             if (assessments[index].status
                                ?.toLowerCase() ==
                                'evaluated') {
                              Fluttertoast.showToast(
                                msg: 'Already you evaluated this assessment',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              return;
                            }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => AssissmentDetailsScreen(
                                        assessmentModel: assessments[index],
                                      ),
                                ),
                              );
                            } else if (assessments[index].status
                                    ?.toLowerCase() ==
                                'evaluated') {
                              Fluttertoast.showToast(
                                msg: 'Already you evaluated this assessment',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg:
                                    'Assessment is not started yet or Assessment finished',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
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
                                ),
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
                                        color: AppColors.primary.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.assignment,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  assessments[index]
                                                          .assessmentTitle ??
                                                      "",
                                                  style: theme
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors.black,
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: _getStatusColor(
                                                    assessments[index].status ??
                                                        '',
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  assessments[index].status ??
                                                      '',
                                                  textAlign: TextAlign.center,
                                                  style: theme
                                                      .textTheme
                                                      .labelSmall
                                                      ?.copyWith(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          // Text(
                                          //   "Technical Screening",
                                          //   style: theme.textTheme.bodySmall
                                          //       ?.copyWith(
                                          //         color: AppColors.grey
                                          //             .withOpacity(0.5),
                                          //       ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                // Info Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.business_center,
                                          size: 16,
                                          color: AppColors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          assessments[index].orgName ?? "",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.timer,
                                          size: 16,
                                          color: AppColors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          " ${assessments[index].assessmentDuration} min",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.score,
                                          size: 16,
                                          color: AppColors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${assessments[index].score?.toStringAsFixed(2) ?? 0}/100",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Started: ${assessments[index].assessmentStartTime?.day} / ${assessments[index].assessmentStartTime?.month} / ${assessments[index].assessmentStartTime?.year} ${assessments[index].assessmentStartTime?.hour}:${assessments[index].assessmentStartTime?.minute} ",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    Text(
                                      "End: ${assessments[index].assessmentEndTime?.day} / ${assessments[index].assessmentEndTime?.month} / ${assessments[index].assessmentEndTime?.year} ${assessments[index].assessmentEndTime?.hour}:${assessments[index].assessmentEndTime?.minute} ",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "evaluated":
        return Colors.green;
      case "pending":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
