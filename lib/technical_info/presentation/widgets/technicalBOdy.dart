import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/models/technical%20info.dart';
import 'package:hireny/technical_info/presentation/manager/technical_info_cubit.dart';
import 'package:hireny/technical_info/presentation/widgets/section.dart';
import 'package:hireny/technical_info/presentation/widgets/skillSection.dart';
import '../../../utils/constants/app_assets.dart';
import 'CVSection.dart';

class Technicalbody extends StatelessWidget {
  const Technicalbody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicalInfoCubit, TechnicalInfoState>(
        builder: (context, state) {
          List<ExperienceModel> ExpData=BlocProvider.of<TechnicalInfoCubit>(context).experiences ?? [];
          if (ExpData.isNotEmpty)
            {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListView(
                  children: [
                    Section(title: "My Experience", img: AppAssets.experienceImg,data: ExpData,),
                    Section(title: "My Education", img: AppAssets.eduImg,data: ExpData,),
                    Section(title: "My Courses", img: AppAssets.courseImg,data: ExpData),
                    Section(title: "My Certificate", img: AppAssets.courseImg,data: ExpData),
                    skillsSection(title: "Skills"),
                    skillsSection(title: "Languages"),
                    CVSection(),
                  ],
                ),
              );
            }
          else if(state is TechnicalInfoFailure)
            {
              return Center(
                child: Text("Failed to load technical information."),
              );
            }
          else {
            return Center(child: CircularProgressIndicator());
          }


        },
      );
  }
}
