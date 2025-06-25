import"package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hireny/technical_info/presentation/manager/technical_info_cubit.dart";
import "package:hireny/technical_info/presentation/widgets/technicalBOdy.dart";
import "package:hireny/utils/widgets/custome_appbar_drawer.dart";

import "../../core/widgets/sideBar.dart";
import "../../routes/page_route.dart";

class technicalInfoView extends StatelessWidget {
  const technicalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen(title: "Technical Info", drawer: SideBarScreen(currentRoute: PagesRoute.techInfo), body: BlocProvider(
      create: (context) {
        final cubit = TechnicalInfoCubit();
        // cubit.getExperience();
        // cubit.getCourses();
        // cubit.getCertificate();
        // cubit.getEducation();
        return cubit;
      },
      child: Technicalbody(),
    ));
  }
}
