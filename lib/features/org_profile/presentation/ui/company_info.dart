import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart'; // Ensure AppColors is imported

class CompanyInfoCard extends StatelessWidget {
  final List<Map<String, dynamic>> infoItems = [
    {"icon": Icons.person, "label": "CEO", "value": "John Smith"},
    {"icon": Icons.calendar_today, "label": "Founded", "value": "2012"},
    {"icon": Icons.groups, "label": "Employees", "value": "150+"},
    {"icon": Icons.business, "label": "Industry", "value": "Tech"},
    {"icon": Icons.location_on, "label": "Location", "value": "San Francisco"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: infoItems.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(item['icon'] as IconData, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(
                '${item['label']}: ',
                style: theme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Text(
                  item['value'] as String,
                  style: theme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
