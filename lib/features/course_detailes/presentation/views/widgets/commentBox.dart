import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';


class comment extends StatelessWidget {
  const comment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.lightPurple,
            boxShadow:[ BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 4)
            )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/comment.png",width: 30,),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 120,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),

                ),
                child: Text(
                    'This is a long block of text that will wrap and grow with its content. '
                        'You can use this to display descriptions or any read-only text area content.',
                    style: AppFonts.textFieldStyle,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis
                ),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.black,
                    child: Text(
                      'HP',
                      style: AppFonts.mainText.copyWith(color: AppColors.white,fontSize: 20),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    'Harsh P.',
                    style: AppFonts.mainText.copyWith(fontSize: 18),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

