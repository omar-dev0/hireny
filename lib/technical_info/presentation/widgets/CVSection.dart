import 'package:flutter/material.dart';
import 'package:hireny/technical_info/presentation/widgets/CVBox.dart';

import '../../../utils/app_fonts.dart';

class CVSection extends StatelessWidget {
  const CVSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Align(alignment:Alignment.centerLeft,child: Text("Upload Your CV",style: AppFonts.textFieldStyle.copyWith(fontSize: 22),)),
          SizedBox(height: 15,),
          CVBox(),
        ],
      ),
    );
  }
}
