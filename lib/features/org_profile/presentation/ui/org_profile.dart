import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_cubit.dart';
import 'package:hireny/features/org_profile/presentation/ui/org_profile_content.dart';
import 'package:hireny/features/org_profile/presentation/ui/widget/review_card.dart';
import 'package:hireny/features/seeker/domain/modules/org_post.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';
import 'package:hireny/utils/di/di.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/data_shared/shared_const_api.dart';
import '../manager/org_profile_states.dart';
import 'company_info.dart';

class OrgProfile extends StatefulWidget {
  final OrgPost orgPost;
  OrgProfile({super.key, required this.orgPost});

  @override
  State<OrgProfile> createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => getIt.get<OrgProfileCubit>()..getOrgJobs(widget.orgPost.id),
      child: DefaultTabController(
        length: 3,
        child: BlocConsumer<OrgProfileCubit, OrgProfilleState>(
          builder: (context, state) {
            return OrgProfileContent(orgPost: widget.orgPost);
          },
          listener: (context, state) {
            if (state is LoadingAddOrgReview) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => LoadingDialog(),
              );
            }

            if (state is HideDialogOrgProfile) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop(); // ✅ Dismiss the dialog
            }

            if (state is ErrorAddOrgReview) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(message: state.error),
              );
            }

            if (state is SuccessAddOrgReview) {
              showDialog(
                context: context,
                builder: (_) => SuccessDialog(message: 'Success'),
              );
            }
          },
        ),
      ),
    );
  }
}
