import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_colors.dart';

class InfoContainer extends StatelessWidget {
  final String category;
  final String time;
  final String price;
  final String location;

  const InfoContainer({
    super.key,
    required this.category,
    required this.time,
    required this.price,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenHeight * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Top Row
          Row(
            children: [
              Icon(Icons.category, color: AppColors.primary),
              SizedBox(width: screenWidth * 0.015),
              Text(
                category,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: screenWidth * 0.035,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: screenWidth * 0.26),

              Icon(Icons.schedule, color: AppColors.primary)   ,
              SizedBox(width: screenWidth * 0.015),
              Text(
                time,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: screenWidth * 0.035,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          /// Bottom Row
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Icon(Icons.attach_money, color: AppColors.primary) ,
              SizedBox(width: screenWidth * 0.015),
              Text(
                price,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: screenWidth * 0.035,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: screenWidth * 0.22),

              Icon(Icons.location_on, color: AppColors.primary) ,
              SizedBox(width: screenWidth * 0.015),
              Text(
                location,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: screenWidth * 0.035,
                  color: Colors.black87,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

