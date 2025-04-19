import 'package:flutter/material.dart';
import 'package:hireny/technical_info/presentation/widgets/popUpTextField.dart';
import 'package:hireny/technical_info/presentation/widgets/pop_up_form.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class sectionHeader extends StatelessWidget {
  const sectionHeader({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(alignment:Alignment.centerLeft,child: Text(title,style: AppFonts.textFieldStyle.copyWith(fontSize: 22),)),
          ElevatedButton(
              onPressed: (){
                popUpForm(context,(){});
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                fixedSize: Size(100, 35)
              ),
              child: Text("Add",style: TextStyle(color: AppColors.white),)
          )

        ],
      ),
    );
  }
}