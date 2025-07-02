import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/org_assessment/presentation/ui/widgets/assessment_card.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../routes/page_route.dart';

class OrgAssessment extends StatelessWidget {
  const OrgAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      title: "Organization Assessments",
      drawer: const SideBarScreen(currentRoute: PagesRoute.myAssessment),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assessments (${AppSharedData.registeredCourses.length})",
              style: AppFonts.mainText,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return FadeInUp(
                    duration: Duration(milliseconds: 300 + index * 100),
                    child: AssessmentCard(index: index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
