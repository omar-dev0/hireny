import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_fonts.dart';

class ReviewDialog extends StatelessWidget {
  final String comment;
  final String personName;

  const ReviewDialog({super.key, required this.comment, required this.personName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title:  Text(personName),
      content: SingleChildScrollView(
        child: Text(
          comment,
          style: AppFonts.textFieldStyle,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
