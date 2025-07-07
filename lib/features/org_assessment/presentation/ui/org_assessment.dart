import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/org_assessment/data/api/assessment_api_manager.dart';
import 'package:hireny/features/org_assessment/data/data_source/assessment_data_source.dart';
import 'package:hireny/features/org_assessment/data/repo_impl/assessment_repo_impl.dart';
import 'package:hireny/features/org_assessment/presentation/ui/widgets/assessment_card.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../routes/page_route.dart';
import '../../../../utils/data_shared/shared_const_api.dart';
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
        child: BlocProvider(
          create: (_) {
            final Dio dio = Dio();
            dio.options.headers = {
              HttpHeaders.contentTypeHeader: 'multipart/form-data',
              if (AppSharedData.user?.accessToken != null)
                HttpHeaders.authorizationHeader:
                    'Bearer ${AppSharedData.user?.accessToken}',
            };
            dio.options.baseUrl = ApiShared.baseUrl;
            if (kDebugMode) {
              dio.interceptors.add(
                PrettyDioLogger(
                  requestHeader: true,
                  requestBody: true,
                  responseBody: true,
                  responseHeader: false,
                  error: true,
                  compact: true,
                  maxWidth: 90,
                  enabled: kDebugMode,
                ),
              );
            }
            var assessment = AssessmentOrgCubit(
              AssessmentRepoImpl(
                AssessmentDataSourceImp(OrgAssessmentApi(dio)),
              ),
            );
            assessment.getAssessment();
            return assessment;
          },
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
      ),
    );
  }
}
