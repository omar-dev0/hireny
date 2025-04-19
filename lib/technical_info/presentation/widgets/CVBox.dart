import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class CVBox extends StatelessWidget {
  const CVBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(14)
      ),
      height: 100,
      child:Row(
        children: [
          ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                fixedSize: Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 👈 Border radius
                ),
              ),
              child: Text("Upload File",style: TextStyle(color: AppColors.white),)
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.secondlightGrey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12), // Top-right corner radius
                    bottomRight: Radius.circular(12), // Bottom-right with no radius
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(alignment:Alignment.centerLeft,child: Text("Upload Your CV...",style: AppFonts.hintStyle.copyWith(fontSize: 15),),),
              ),
            ),
          ),
          SizedBox(width: 7,)
        ],
      ),
    );
  }
}

