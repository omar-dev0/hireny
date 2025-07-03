import 'package:flutter/material.dart';

class ApplicantAvatars extends StatelessWidget {
  final int totalApplicants;

  const ApplicantAvatars({super.key, required this.totalApplicants});

  @override
  Widget build(BuildContext context) {
    final count = totalApplicants.clamp(0, 3);

    return Row(
      children: List.generate(3, (index) {
        final isFilled = index < count;
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: isFilled ? Colors.blue : Colors.grey.shade300,
            child: Icon(
              Icons.person,
              size: 14,
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }
}
