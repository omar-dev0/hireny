// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hireny/features/org_profile/presentation/ui/widget/job_info.dart';
// import '../../../../../utils/app_assets.dart';
// import '../../../../../utils/constants/app_colors.dart';
// import '../../../../../utils/data_shared/shared_const_api.dart';
// import '../../../../seeker/domain/modules/job_details.dart';
// import '../../manager/org_profile_cubit.dart';
// import '../../manager/org_profile_states.dart';
//
// class PostCard extends StatelessWidget {
//   const PostCard({super.key});
//
// }
//
// @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<OrgProfileCubit, OrgProfilleState>(
//       builder: (context, state) {
//         if (state is LoadingOrgJobs) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is ErrorLoadedPosts) {
//           return Center(child: Text(state.error));
//         }
//         return
//       },
//     );
//   }
//
// }
