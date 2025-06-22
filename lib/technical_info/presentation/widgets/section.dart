import 'package:flutter/material.dart';
import 'package:hireny/models/technical%20info.dart';
import 'package:hireny/technical_info/presentation/widgets/sectionHeader.dart';

import 'InfoBox.dart';

class Section extends StatelessWidget {
  const Section({super.key, required this.title, required this.img, required this.data});
  final String title;
  final String img;
  final List<TechnicalInfo> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionHeader(title: title,),
        SizedBox(
          height: 320,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return InfoBox(isExp: true,img: img,info: data[0],);
            },
          ),
        ),
      ],
    );
  }
}
