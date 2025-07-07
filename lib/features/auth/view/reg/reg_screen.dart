import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hireny/features/auth/domain/modules/auto_fill/autofill.dart';
import 'package:hireny/features/auth/view/reg/cubit/reg_vm.dart';
import 'package:hireny/features/auth/view/reg/reg_org_content.dart';
import 'package:hireny/features/auth/view/reg/reg_seeker_content.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';
import 'package:hireny/utils/constants/dialogs/toast/error.dart';
import 'package:hireny/utils/di/di.dart';
import '../../../../utils/lang/lang.dart';
import '../../domain/modules/auto_fill/auto_fill_org_admin.dart';
import '../../domain/modules/auto_fill/autofill_seeker.dart';
import 'cubit/state/reg_states.dart';

class RegSeekerScreen extends StatelessWidget {
  bool isOrg;
  AutoFill? autoFill;
  String? cv;
  RegSeekerScreen({
    super.key,
    required this.isOrg,
    required this.autoFill,
    this.cv,
  });
  final RegSeekerVm regVm = getIt.get<RegSeekerVm>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        if (autoFill is AutoFillSeeker) {
          regVm.loadSeekerData(autoFill as AutoFillSeeker, cv: cv);
        } else if (autoFill is AutoFillOrg) {
          regVm.loadOrgData(autoFill as AutoFillOrg, cv: cv);
        }
        return regVm;
      },
      child: BlocConsumer<RegSeekerVm, RegState>(
        listener: (context, state) {
          if (state is RegSuccess) {
            Future.delayed(
              Duration(seconds: 2),
              () =>
                  Navigator.pushReplacementNamed(context, PagesRoute.firstPage),
            );
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => SuccessDialog(),
            );
          }
          if (state is RegError) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: state.message),
            );
          } else if (state is LoadingReg) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const LoadingDialog(),
            );
          } else if (state is HideRegLoading) {
            Navigator.pop(context);
          } else if (state is ValidateDate) {
            showError(Lang.notValidDate);
          } else if (state is ValidateGender) {
            showError(Lang.validateGenderEmpty);
          } else if (state is ValidateNationality) {
            showError(Lang.validateNationalityEmpty);
          } else if (state is ValidateCountry) {
            showError(Lang.validateCountryEmpty);
          } else if (state is ValidateCity) {
            showError(Lang.validateCityEmpty);
          } else if (state is ValidateCareerLevel) {
            showError(Lang.validateCareerLevelEmpty);
          } else if (state is ValidateEmploymentStatus) {
            showError(Lang.validateEmploymentStatusEmpty);
          } else if (state is ValidateFile) {
            showError(Lang.validateFileEmpty);
          } else if (state is ValidateIndestry) {
            showError(Lang.validateIndustryEmpty);
          } else if (state is ValidateOrgSize) {
            showError(Lang.validateOrgSizeEmpty);
          }
        },
        builder:
            (context, state) =>
                isOrg ? const RegOrgContent() : const RegSeekerContent(),
      ),
    );
  }
}
