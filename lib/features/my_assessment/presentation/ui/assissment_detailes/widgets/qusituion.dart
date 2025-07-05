import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/widgets/check_box_q.dart';
import '../../../../../../utils/constants/app_fonts.dart';

class Qusituion extends StatelessWidget {
  final String question;
  final Widget answer;

  const Qusituion({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      // Animation wrapper from animate_do
      duration: Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.secMain.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          answer,
        ],
      ),
    );
  }
}
