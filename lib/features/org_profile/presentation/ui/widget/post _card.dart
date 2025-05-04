import 'package:flutter/material.dart';
import 'package:hireny/features/org_profile/presentation/ui/widget/job_info.dart';

import '../../../../../utils/constants/app_colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '24 min ago',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.grey.withOpacity(0.1),
                  child: Icon(Icons.business, color:AppColors.primary),
                ),
                const SizedBox(width: 10),
                Text(
                  'Internal Creative Coordinator',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                JobInfo(icon: Icons.work, text: 'Commerce'),
                  JobInfo(icon: Icons.access_time, text: 'Full time'),
                  JobInfo(icon: Icons.attach_money, text: '\$44000'),
                  JobInfo(icon: Icons.location_on, text: 'New-York, USA'),
              ],
            ),
          ]
      ),

    );
  }
}
