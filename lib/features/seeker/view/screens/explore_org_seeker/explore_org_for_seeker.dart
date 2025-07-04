// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
// import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
// import 'package:hireny/utils/di/di.dart';
//
// import '../../../../../utils/constants/app_colors.dart';
// import '../../../../../utils/constants/helper_functions.dart';
// import '../../../../../utils/data_shared/app_shared_data.dart';
// import 'cubit/explore_org_for_seeker_cubit.dart';
// import 'cubit/explore_org_for_seeker_states.dart';
// import 'explore_org_for_seeker_content.dart';
//
// class ExploreOrgForSeeker extends StatelessWidget {
//
//    ExploreOrgForSeeker({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<OrgPostCubit, OrgPostState>(
//       listener: (context, state) {
//         if (state is OrgPostLoading) {
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (_) => LoadingDialog(),
//           );
//         }
//
//         if (state is OrgPostError) {
//           Navigator.pop(context);
//           showDialog(
//             context: context,
//             builder: (_) => ErrorDialog(message: state.message),
//           );
//         }
//
//       },
//       builder: (context, state) {
//           if (state is OrgPostLoading ) {
//           return LoadingDialog();
//         }
//
//         return Scaffold(
//           backgroundColor: AppColors.subPrimary,
//           body: state is OrgPostLoading && AppSharedData.orgPosts.isEmpty
//               ? Center(child: CircularProgressIndicator())
//               : ExploreOrgForSeekerContent(
//             chipLabels: ['Location', 'Industry', 'Size'],
//             onChipPressed: [
//                   () => _showLocationBottomSheet(context),
//                   () => _showCategoryBottomSheet(context),
//                   () => _showOrganizationSizeBottomSheet(context),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showLocationBottomSheet(BuildContext context) {
//     showDynamicBottomSheet(
//       context: context,
//       title: "Select Location",
//       items: AppSharedData.countryCityData.keys.toList(),
//     );
//   }
//
//   void _showCategoryBottomSheet(BuildContext context) {
//     showDynamicBottomSheet(
//       context: context,
//       title: "Select your category",
//       items: [
//         "Commerce",
//         "Telecommunications",
//         "Hotels & Tourism",
//         "Education",
//         "Financial Services",
//       ],
//     );
//   }
//
//   void _showOrganizationSizeBottomSheet(BuildContext context) {
//     showDynamicBottomSheet(
//       context: context,
//       title: "Select Organization Size",
//       items: AppSharedData.organizationSizes,
//     );
//   }
// }