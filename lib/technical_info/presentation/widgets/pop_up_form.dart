import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/technical_info/presentation/widgets/form_add_info.dart';
import 'package:hireny/technical_info/presentation/widgets/popUpButtons.dart';
import '../../../utils/constants/app_colors.dart';
import '../manager/technical_info_cubit.dart';
// form without fields
void popUpForm(BuildContext context, Function()? onPressed, String title,
    {bool updateFlag = false,dynamic type}) {
  final techCubit = BlocProvider.of<TechnicalInfoCubit>(context);

  techCubit.setFlagByTitle(title);
  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: techCubit,
        child: Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: SizedBox(
                width: 600,
                height: 460,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormAddInfo(type: type),
                      const SizedBox(height: 30),
                      popUpButtons(
                        onPressed: () {
                          if (techCubit.formKey.currentState!.validate()) {
                            if(updateFlag){
                              onPressed?.call();
                              Navigator.pop(dialogContext);
                            }else{
                              techCubit.addTechInfo();
                              // onPressed?.call();
                              Navigator.pop(dialogContext);
                            }

                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
