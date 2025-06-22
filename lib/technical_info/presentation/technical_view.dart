import"package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hireny/technical_info/presentation/manager/technical_info_cubit.dart";
import "package:hireny/technical_info/presentation/widgets/CVSection.dart";
import "package:hireny/technical_info/presentation/widgets/section.dart";
import "package:hireny/technical_info/presentation/widgets/skillSection.dart";
import "package:hireny/technical_info/presentation/widgets/technicalBOdy.dart";
import "package:hireny/utils/constants/app_assets.dart";

import "../../core/widgets/sideBar.dart";
import "../../utils/constants/app_colors.dart";
import "../../utils/constants/app_fonts.dart";


class technicalInfoView extends StatelessWidget {
  const technicalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        drawer: SideBar(),
        appBar: AppBar(
          title: Center(
              child: Text("Technical Info", style: AppFonts.mainText,)),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: AppColors.primary),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          ],
        ),
        body: BlocProvider(
          create: (context) {
                final cubit = TechnicalInfoCubit();
                // cubit.getExperience();
                // cubit.getCourses();
                // cubit.getCertificate();
                // cubit.getEducation();
                return cubit;
          },
          child: Technicalbody(),
        )

    );
  }
}
