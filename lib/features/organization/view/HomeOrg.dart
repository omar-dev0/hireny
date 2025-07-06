import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/organization/domain/modules/service.dart';
import 'package:hireny/features/organization/view/screens/explore_services/cubit/explore_services_cubit.dart';
import 'package:hireny/features/organization/view/screens/explore_services/cubit/explore_services_states.dart';
import 'package:hireny/features/organization/view/widgets/serivce_card.dart';
import 'package:hireny/features/seeker/view/screens/explore_job/cubit/explore_job_cubit.dart';
import 'package:hireny/features/seeker/view/screens/explore_job/cubit/explore_job_states.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/widgets/job_explore_card.dart';

import '../../../routes/page_route.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/widgets/custom_search_bar.dart';

class HomeOrg extends StatefulWidget {
  const HomeOrg({super.key});

  @override
  State<HomeOrg> createState() => _HomeState();
}

class _HomeState extends State<HomeOrg> {

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ExploreServicesCubit>(context);

    return BlocBuilder<ExploreServicesCubit, ExploreServicesState>(
      builder: (context, state) {
        List<ServiceModel> servicePosts = [];

        if (state is ServicesLoaded && state.services.isNotEmpty == true) {
          servicePosts = state.services.take(5).toList();
        } else if (AppSharedData.services.isNotEmpty == true) {
          servicePosts = AppSharedData.services!.take(5).toList();
        } else {
          servicePosts = [];
        }
        return Padding(
          padding: const EdgeInsets.all(20),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: FadeInUp(
                  child: Image.asset(
                    'assets/images/main_screen.png',
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              //👇 Animated Search Field
              SliverToBoxAdapter(
                child: FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: CustomSearchBar(
                    hintText: "Search for Services",
                    onSearchChanged: (value) {
                      context.read<ExploreServicesCubit>().filterServices(value);
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              SliverToBoxAdapter(
                child: Text(
                  'Featured Services',
                  textAlign: TextAlign.center,
                  style: AppFonts.mainText,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              //👇 Animated Job Cards
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final servicePost = servicePosts[index];
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * index),
                      duration: Duration(milliseconds: 600),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PagesRoute.serviceDetailsOrg,
                              arguments: {'service': servicePost, 'cubit': cubit},
                            );
                          },
                          child: ServiceCardOrgExplore(service: servicePost),
                        ),
                      ),
                    );
                  },
                  childCount: servicePosts.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}