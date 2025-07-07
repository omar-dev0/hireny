import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/org_assessment/presentation/ui/widgets/assessment_card.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../routes/page_route.dart';
import '../manager/assessment_org_cubit.dart';
import '../manager/assessment_org_states.dart';
class OrgAssessment extends StatelessWidget {
  const OrgAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      title: "Organization Assessments",
      drawer: const SideBarScreen(currentRoute: PagesRoute.orgAssessment),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AssessmentOrgCubit, AssessmentOrgStates>(
          builder: (context, state) {
            if (state is AssessmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssessmentFailure) {
              return const Center(child: Text("Failed to load assessments"));
            } else if (state is AssessmentSuccess) {
              final assessments = AppSharedData.assessmentsOrg;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assessments (${assessments.length})",
                    style: AppFonts.mainText,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: assessments.length,
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
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
