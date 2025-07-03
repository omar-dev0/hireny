import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../../../utils/constants/app_colors.dart';
import 'commentBox.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: Duration(milliseconds: 300 + (index * 200)),
              child: comment(),
            );
          },
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .52,
          right: 20,
          child: ZoomIn(
            duration: const Duration(milliseconds: 600),
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Icon(Icons.add, color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
