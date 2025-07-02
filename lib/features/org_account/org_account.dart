import 'package:flutter/material.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';

import '../../routes/page_route.dart';

class OrgAccount extends StatelessWidget {
  const OrgAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
        title: "account",
        drawer: SideBarScreen(currentRoute: PagesRoute.orgAccount),
        body: Column());
  }
}
