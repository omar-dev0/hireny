import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/constants/helper_functions.dart';

import 'cubit/explore_services_cubit.dart';
import 'cubit/explore_services_states.dart';
import 'explore_services_org_content.dart';

class ExploreServicesOrg extends StatelessWidget {
  static String routeName = "ExploreServicesOrg";

  const ExploreServicesOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExploreServicesCubit, ExploreServicesState>(
      listener: (context, state) {
        if (state is ExploreServicesLoading && AppSharedData.services.isEmpty) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => LoadingDialog(),
          );
        }
        if (state is ServicesError) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(message: state.message),
          );
        }
      },
      builder: (context, state) {
        if (state is ExploreServicesLoading && AppSharedData.services.isEmpty) {
          return LoadingDialog();
        }

        final cubit = BlocProvider.of<ExploreServicesCubit>(context);

        return Scaffold(
          backgroundColor: AppColors.subPrimary,
          body: ExploreServicesOrgContent(
            chipLabels: ['Category', 'Price'],
            onChipPressed: [
                  () => _showCategoryBottomSheet(context),
                  () => _showPriceRangeBottomSheet(context),
            ],
          ),
        );
      },
    );
  }

  void _showCategoryBottomSheet(BuildContext context) {
    final cubit = context.read<ExploreServicesCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select your category",
      items: [
        "Agriculture",
        "Automotive",
        "Banking",
        "Construction",
        "Consumer Goods",
        "Education",
        "Energy & Utilities",
        "Entertainment",
        "Environmental Services",
        "Fashion & Apparel",
        "Food & Beverage",
        "Government",
        "Healthcare",
        "Hospitality & Tourism",
        "Information Technology",
        "Insurance",
        "Legal Services",
        "Logistics & Transportation",
        "Manufacturing",
        "Media & Communications",
        "Mining",
        "Nonprofit",
        "Pharmaceuticals",
        "Real Estate",
        "Retail",
        "Software Development",
        "Telecommunications",
        "Textiles",
        "Waste Management",
        "Wholesale & Distribution",
      ],
      initialSelection: cubit.selectedCategoryIndices,
      onSelectedIndicesChanged: (indices) {
        cubit.updateCategoryFilter(indices);
      },
    );
  }

  void _showPriceRangeBottomSheet(BuildContext context) {
    final cubit = context.read<ExploreServicesCubit>();
    showDynamicInputBottomSheet(
      context: context,
      title: "Select Price Range",
      minHint: "Min Price",
      maxHint: "Max Price",
      buttonText: "Filter",
      onpress: (min, max) {
        cubit.updatePriceRangeFilter(min: min, max: max);
      },
    );
  }
}