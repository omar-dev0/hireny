import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class GeneralUserInfo extends StatelessWidget {
  final List<Map<String, dynamic>> infoItems = [
    {"icon": Icons.email_rounded, "label": "Email", "value": "XXXX@gmail.com"},
    {"icon": Icons.phone_rounded, "label": "Phone", "value": "+201220212229"},
    {"icon": Icons.person_rounded, "label": "Age", "value": "23"},
    {"icon": Icons.language_rounded, "label": "Nationality", "value": "Egyptian"},
    {"icon": Icons.location_pin, "label": "Location", "value": "New York, USA"},
    {"icon": Icons.work_rounded, "label": "Career Level", "value": "Senior"},
    {"icon": Icons.business_center_rounded, "label": "Employment", "value": "Unemployed"},
    {"icon": Icons.event_available_rounded, "label": "Availability", "value": "Immediately"},
    {"icon": Icons.file_present_rounded, "label": "CV", "value": "Download PDF"},
    {"icon": Icons.link_rounded, "label": "LinkedIn", "value": "linkedin.com/XXXXX"},
  ];

  GeneralUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with subtle underline
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                "General Information",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : AppColors.black,
                ),
              ),
              const SizedBox(height: 16),
               ]
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? theme.colorScheme.surfaceVariant
                      : Colors.grey[50],
                ),
                child: Column(
                  children: List.generate(infoItems.length, (index) {
                    final item = infoItems[index];
                    final isLast = index == infoItems.length - 1;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.subPrimary,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Icon(
                                  item['icon'],
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Label and Value
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['label'],
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.textTheme.bodySmall?.color
                                            ?.withOpacity(0.7),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (item['label'] == "CV" || item['label'] == "LinkedIn")
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          item['value'],
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      )
                                    else
                                      Text(
                                        item['value'],
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Divider
                        if (!isLast)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: theme.dividerColor.withOpacity(0.1),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}