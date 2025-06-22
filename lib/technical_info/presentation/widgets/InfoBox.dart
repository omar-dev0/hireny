import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/models/technical%20info.dart';
import 'package:hireny/technical_info/presentation/widgets/popUpEXPForm.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_fonts.dart';
import '../manager/technical_info_cubit.dart';


class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key, required this.isExp, required this.img, required this.info,
  });
  final bool isExp;
  final String img;
  final TechnicalInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12)
          ),
          height: 180,
          child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                SizedBox(
                    width:65,
                    height: 80,
                    child: Image.asset(img)
                ),
                SizedBox(width: 35,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible:isExp,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 160,bottom: 10,top: 4),
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primary,

                          ),
                          child: Center(child: Text("InternShip",style: TextStyle(color: AppColors.white
                          ),)),
                        ),
                      ),
                    ),
                    Text(info.title,style: AppFonts.textFieldStyle.copyWith(fontSize: 20),),
                    SizedBox(height: 10,),
                    Text(info.organization,style: AppFonts.secMain,),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("${info.startDate} - ${info.endDate}",style: AppFonts.hintStyle.copyWith(fontSize: 16),),
                        SizedBox(width: 60,),
                        IconButton(onPressed: ()
                        {
                          popUpForm(context,
                              () {
                                //   if (_formKey.currentState!.validate()) {
                                //     // All fields are valid
                                //     Navigator.pop(context);
                                //     print(_nameController.value);
                                //
                                // }
                              }
                          );

                        }, icon: Icon(Icons.edit)),
                        IconButton(onPressed: ()
                        {
                          context.read<TechnicalInfoCubit>().deleteEXperience(id: 1);

                        }, icon: Icon(Icons.delete))
                      ],
                    )

                  ],
                )
              ],
            ),
          ),
        )
      ] ,
    );
  }
}
