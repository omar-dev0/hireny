import 'package:flutter/material.dart';
import 'package:hireny/technical_info/data/models/response/skill_model.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import '../../../utils/constants/app_colors.dart';
import '../../data/models/response/lang_model.dart';
import 'sectionHeader.dart';

class SkillsSection extends StatelessWidget {
  final String title;
  final dynamic cubit;

  const SkillsSection({
    super.key,
    required this.title,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final isSkill = title == "Skills";
    final items = AppSharedData.techInfo?[isSkill ? "skills" : "lang"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(title: title),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.subPrimary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary),
          ),
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final displayText = item is SkillModel
                  ? item.skillName
                  : (item is LanguageModel ? item.languageName : item.toString());
              final itemId = item is SkillModel
                  ? item.id
                  : (item is LanguageModel ? item.id : null);

              return InkWell(
                onTap: (){
                  print(item.runtimeType);
                  cubit.deleteItem("$itemId",item);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                          displayText ?? '',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        ),
      ],
    );
  }
}
