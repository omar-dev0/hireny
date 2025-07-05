import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';

class ApplicantAvatar extends StatelessWidget {
  final int total;
  final double size;
  final int maxIcons;

  const ApplicantAvatar({
    super.key,
    required this.total,
    this.size = 36,
    this.maxIcons = 5,
  });

  @override
  Widget build(BuildContext context) {
    final visibleCount = total > maxIcons ? maxIcons : total;
    final avatarRadius = size / 2;

    return Align(
      alignment: Alignment.centerLeft, // 👈 Ensures it's on the left side
      child: SizedBox(
        height: size,
        width: size + (visibleCount - 1) * (size * 0.6),
        child: Stack(
          children: List.generate(visibleCount, (index) {
            return Positioned(
              left: index * (size * 0.6),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: AppColors.subPrimary.withOpacity(0.5),
                child: CircleAvatar(
                  radius: avatarRadius - 2,
                  backgroundColor: AppColors.grey.withOpacity(0.4),
                  child: Icon(
                    Icons.person,
                    size: size * 0.5,
                    color: AppColors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

}
