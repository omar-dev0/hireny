import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_search_bar.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import 'package:hireny/features/organization/domain/modules/service.dart';
import 'package:hireny/routes/page_route.dart';

import '../../../../../utils/data_shared/app_shared_data.dart';
import '../../widgets/serivce_card.dart';
import 'cubit/explore_services_cubit.dart';
import 'cubit/explore_services_states.dart' as states;

class ExploreServicesOrgContent extends StatelessWidget {
  final List<String> chipLabels;
  final List<Function()?> onChipPressed;

  const ExploreServicesOrgContent({
    super.key,
    required this.chipLabels,
    required this.onChipPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ExploreServicesCubit>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                CustomSearchBar(
                  hintText: "Search for services",
                  onSearchChanged: (value) {
                    cubit.filterServices(value);
                  },
                ),
                SizedBox(height: 20.h),
                Text("Explore Services", style: AppFonts.mainText),
                Text(
                  "Discover services to boost your company and achieve your goals.",
                  style: AppFonts.secMain,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                BlocBuilder<ExploreServicesCubit, states.ExploreServicesState>(
                  builder: (context, state) {
                    // Determine which chips are 'selected' based on the cubit's filter state
                    Set<int> selectedChips = {};
                    if (cubit.selectedCategoryIndices.isNotEmpty) {
                      selectedChips.add(chipLabels.indexOf('Category'));
                    }
                    if (cubit.minPriceFilter != null || cubit.maxPriceFilter != null) {
                      selectedChips.add(chipLabels.indexOf('Price'));
                    }

                    return DynamicFilterChipsWidget(
                      chipLabels: chipLabels,
                      onChipPressed: onChipPressed,
                      selectedChipIndices: selectedChips,
                    );
                  },
                ),
                SizedBox(height: 24.h),
                Text("All Services (${AppSharedData.services.length})", style: AppFonts.mainText),
                SizedBox(height: 15.h),
              ],
            ),
          ),
          BlocBuilder<ExploreServicesCubit, states.ExploreServicesState>(
            builder: (context, state) {
              if (state is states.ServicesLoaded && state.services.isNotEmpty) {
                return SliverList.builder(
                  itemCount: state.services.length,
                  itemBuilder: (context, index) {
                    final service = state.services[index];
                    return Column(
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 300 + index * 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PagesRoute.serviceDetailsOrg,
                                arguments: {'service': service, 'cubit': cubit},
                                );
                            },
                            child: ServiceCardOrgExplore(service: service),
                          ),
                        ),
                        SizedBox(height: 15.h),
                      ],
                    );
                  },
                );
              } else if (state is states.ServicesLoaded && state.services.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text("No services found.", style: AppFonts.secMain),
                  ),
                );
              } else {
                return SliverToBoxAdapter(child: Container());
              }
            },
          ),
        ],
      ),
    );
  }
}