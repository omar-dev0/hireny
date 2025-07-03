import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/view/widgets/related_service_card.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import 'package:hireny/utils/widgets/search_bar_widget.dart';

import '../../../../../utils/constants/helper_functions.dart';
import '../../../../../utils/widgets/custom_search_bar.dart';
import '../../../../../utils/widgets/explore_card.dart';
import '../../../../services/presentation/ui/widgets/service_card_org.dart';
import '../../widgets/serivce_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';

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
        if (state is ExploreServicesLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => LoadingDialog(),
          );        }
        if (state is ServicesError) {
          Navigator.pop(context);
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
    showDynamicBottomSheet(
      context: context,
      title: "Select your category",
      items: AppSharedData.industries,
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
      // onpress: (min, max) {
      //   // cubit.updatePriceFilter(min: double.tryParse(min), max: double.tryParse(max));
      // },
    );
  }
}