import 'package:flutter/material.dart';
import 'package:hireny/features/user_profile/domain/entities/card_model.dart';

import '../../../../../utils/constants/app_colors.dart';

class CustomInfoCard extends StatelessWidget {
  final List<CardModel> info;
  const CustomInfoCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: info.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder:
            (context, index) => Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 68,
                      height: 68,
                      child: info[index].image,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                info[index].title,
                                style: theme.titleMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (info[index].badge != null)
                              Text(
                                info[index].badge!,
                                style: theme.bodySmall?.copyWith(
                                  color: AppColors.primary.withOpacity(0.4),
                                  fontWeight: FontWeight.w600,
                                  decoration:
                                      info[index].isLink != null
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          info[index].subtitle,
                          style: theme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(info[index].duration, style: theme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
