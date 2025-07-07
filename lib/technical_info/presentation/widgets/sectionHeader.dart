import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/technical_info/presentation/manager/technical_info_cubit.dart';
import 'package:hireny/technical_info/presentation/widgets/popUpTextField.dart';
import 'package:hireny/technical_info/presentation/widgets/showListDialog.dart';
import 'package:hireny/technical_info/presentation/widgets/pop_up_form.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_fonts.dart';

class sectionHeader extends StatelessWidget {
  const sectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TechnicalInfoCubit>();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppFonts.textFieldStyle.copyWith(fontSize: 22),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (title == "Languages") {
                showListDialog(
                  context,
                  AppSharedData.lang,
                  cubit, isSkill: false,
                  
                );
              } else if (title == "Skills") {
                showListDialog(
                  context,
                  AppSharedData.skills,
                 cubit, isSkill: true,
                );
              } else {
                popUpForm(context, () {}, title);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              fixedSize: const Size(100, 35),
            ),
            child: const Text(
              "Add",
              style: TextStyle(color: AppColors.white),
            ),
          )
        ],
      ),
    );
  }
}
