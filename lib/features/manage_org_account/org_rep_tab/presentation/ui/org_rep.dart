import 'package:flutter/material.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/routes/page_route.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/widgets/custome_appbar_drawer.dart';

class OrgRep extends StatelessWidget {
  const OrgRep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScreen(
      title: 'Organization Representatives',
      drawer: SideBarScreen(currentRoute: PagesRoute.orgRep),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                label: Text(
                  "Add Admin",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.subPrimary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary, width: 1),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      /// Avatar
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: const Icon(Icons.person, color: AppColors.primary, size: 28),
                      ),
                      const SizedBox(height: 8),

                      /// Name
                      Text(
                        "Admin ${index + 1}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),

                      /// Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18, color: AppColors.primary),
                            onPressed: () {},
                            tooltip: 'Edit',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 18, color: AppColors.red),
                            onPressed: () {},
                            tooltip: 'Delete',
                          ),
                        ],
                      ),

                      /// Join Date
                      const SizedBox(height: 4),
                      Text(
                        "Joined: 2022-10-0${index + 1}",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
