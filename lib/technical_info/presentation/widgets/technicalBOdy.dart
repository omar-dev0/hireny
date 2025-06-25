import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
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
        List<ExperienceModel> ExpData = BlocProvider.of<TechnicalInfoCubit>(context).experiences ?? [];

        if (ExpData.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ListView(
              children: [
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  child: Section(
                    title: "My Experience",
                    img: AppAssets.experienceImg,
                    data: ExpData,
                  ),
                ),
                SizedBox(height: 20),
                FadeInRight(
                  duration: Duration(milliseconds: 600),
                  child: Section(
                    title: "My Education",
                    img: AppAssets.eduImg,
                    data: ExpData,
                  ),
                ),
                SizedBox(height: 20),
                FadeInLeft(
                  duration: Duration(milliseconds: 700),
                  child: Section(
                    title: "My Courses",
                    img: AppAssets.courseImg,
                    data: ExpData,
                  ),
                ),
                SizedBox(height: 20),
                FadeInRight(
                  duration: Duration(milliseconds: 800),
                  child: Section(
                    title: "My Certificate",
                    img: AppAssets.courseImg,
                    data: ExpData,
                  ),
                ),
                SizedBox(height: 20),
                ElasticIn(
                  duration: Duration(milliseconds: 900),
                  child: skillsSection(title: "Skills"),
                ),
                SizedBox(height: 20),
                ElasticIn(
                  duration: Duration(milliseconds: 1000),
                  child: skillsSection(title: "Languages"),
                ),
                SizedBox(height: 20),
                BounceInUp(
                  duration: Duration(milliseconds: 1100),
                  child: CVSection(),
                ),
              ],
            ),
          );
        }
        else if (state is TechnicalInfoFailure) {
          return Bounce(
            child: Center(
              child: Text("Failed to load technical information."),
            ),
          );
        }
        else {
          return FadeIn(
            duration: Duration(milliseconds: 500),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}