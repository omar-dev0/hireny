import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/services/presentation/ui/service_details.dart';
import 'package:hireny/features/services/presentation/ui/widgets/profile_avatar.dart';
import 'package:hireny/features/services/presentation/ui/widgets/service_card_org.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';

import '../../../../utils/di/di.dart';
import '../manager/service_org_cubit.dart';
import '../manager/service_org_states.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      title: "Services",
      drawer: SideBarScreen(currentRoute: PagesRoute.myCourses),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: BlocBuilder<ServiceOrgCubit, ServiceOrgStates>(
                builder: (context, state) {
                  return Text(
                    "Available Services (${AppSharedData.servicesOrg.length})",
                    style: AppFonts.mainText,
                  );
                }
              ),
            ),
            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, PagesRoute.orgServicePost);
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text("Add New Post"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),


            const SizedBox(height: 12),

            Expanded(
              child: BlocBuilder<ServiceOrgCubit, ServiceOrgStates>(
                builder: (context, state) {
                  if (state is LoadingServiceOrg) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (AppSharedData.servicesOrg.isEmpty) {
                    return const Center(child: Text("No services found."));
                  }

                  return GridView.builder(
                    itemCount: AppSharedData.servicesOrg.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.80,
                    ),
                    itemBuilder: (context, index) {
                      final service = AppSharedData.servicesOrg[index];

                      return FadeInUp(
                        duration: Duration(milliseconds: 400 + index * 100),
                          child: InkWell(
                            onTap: () async {
                              final service = AppSharedData.servicesOrg[index];

                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ServiceOrgCubit>(), // reuse current cubit
                                    child: ServiceDetailsScreen(serviceObj: service),
                                  ),
                                ),
                              );

                              if (result == 'deleted') {
                                context.read<ServiceOrgCubit>().loadServices(); // ✅ refresh on return
                              }
                            },
                            child: ServiceCardOrg(
                              name: service.serviceTitle,
                              price: "${service.salary} ${service.currency.isNotEmpty ? service.currency[0] : ''}",
                              footer: ApplicantAvatar(size: 30,total: AppSharedData.servicesOrg[index].totalApplications,),
                            ),
                        ),
                      );
                    },
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
