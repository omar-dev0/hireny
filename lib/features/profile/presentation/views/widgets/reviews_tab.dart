import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';
import 'commentBox.dart';


class reviewsTab extends StatelessWidget {
  const reviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 3,
          itemBuilder: (context,index)
          {
            return comment();
          },
        ),
        Positioned(
          top: 530,
          right: 20,
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // <-- change this
                ),
              ),
              child: Icon(Icons.add,color: AppColors.white,),

            ),
          ),
        )
      ],
    );
  }
}


