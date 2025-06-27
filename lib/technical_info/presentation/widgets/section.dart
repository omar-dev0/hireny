import 'package:flutter/material.dart';
import 'package:hireny/models/technical%20info.dart';
import 'package:hireny/technical_info/presentation/widgets/sectionHeader.dart';

import 'InfoBox.dart';

class Section extends StatelessWidget {
  const Section({super.key, required this.title, required this.img, required this.data,});
  final String title;
  final String img;
  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionHeader(title: title, onAddPressed: () {  },),
        SizedBox(
          height: 320,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InfoBox(img: img,info: data[index]);
            }, separatorBuilder: (BuildContext context, int index)=>SizedBox(width: 16,),
          ),
        ),
      ],
    );
  }
}
