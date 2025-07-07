import 'package:flutter/material.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import '../../../../../utils/constants/app_colors.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/features/org_assessment/data/models/assessment_model.dart';

class AssessmentCard extends StatelessWidget {
  final int index;
  const AssessmentCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user =AppSharedData.user?.role as OrgAdmin ;
    final AssessmentResponse assessment = AppSharedData.assessmentsOrg[index];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary),
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
          /// Title & Actions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    /// Title and Dropdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            assessment.assessmentTitle ?? "No title",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Edit pressed")),
                              );
                            } else if (value == 'delete') {
                              _confirmDelete(context);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: const [
                                  Icon(Icons.edit, size: 18, color: AppColors.primary),
                                  SizedBox(width: 8),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: const [
                                  Icon(Icons.delete, size: 18, color: AppColors.red),
                                  SizedBox(width: 8),
                                  Text('Delete', style: TextStyle(color: AppColors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Text(
                    //   assessment. ?? "No description",
                    //   style: theme.textTheme.bodySmall?.copyWith(
                    //     color: AppColors.grey.withOpacity(0.6),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Icon Info
          Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.business_center, size: 16, color: AppColors.grey),
                  const SizedBox(width: 4),
                  Text(user.companyName!, style: const TextStyle(fontSize: 13))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer, size: 16, color: AppColors.grey),
                  const SizedBox(width: 4),
                  Text("${assessment.assessmentDuration ?? 0} min", style: const TextStyle(fontSize: 13)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.score, size: 16, color: AppColors.grey),
                  const SizedBox(width: 4),
                  Text("${assessment.questions.length ?? '--'}", style: const TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Dates
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Started: ${assessment.createdAt ?? 'N/A'}",
                  style: theme.textTheme.bodySmall,
                ),
              ),
              Flexible(
                child: Text(
                  "Completed: ${assessment.updatedAt ?? 'N/A'}",
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this assessment?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Assessment deleted")),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
