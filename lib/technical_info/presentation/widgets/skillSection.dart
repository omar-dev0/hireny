import 'package:flutter/material.dart';
import 'package:hireny/technical_info/presentation/widgets/pop_up_List.dart';
import 'package:hireny/technical_info/presentation/widgets/sectionHeader.dart';
import 'package:hireny/technical_info/presentation/widgets/skillBox.dart';
import '../../../utils/constants/app_colors.dart';

class SkillsSection extends StatelessWidget {
  final String title;

  const SkillsSection({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> skills = ["Java", "Flutter", "Dart", "Python", "SQL"]; // Example

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(
          title: title,
          onAddPressed: () {
            showSkillSearchDialog(context,skills,)
            ;          },
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.subPrimary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary)
          ),
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: skills.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8), // optional spacing
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "skillName",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        ),
      ],
    );
  }
}
