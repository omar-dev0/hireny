import 'package:flutter/material.dart';
import 'package:hireny/features/services/presentation/ui/widgets/info_row.dart';
import 'package:hireny/utils/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/widgets/custom_buttom.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String title;
  final String company;
  final String postedTime;
  final String category;
  final String time;
  final String price;
  final String location;
  final String description;

  const ServiceDetailsScreen({
    super.key,
    required this.title,
    required this.company,
    required this.postedTime,
    required this.category,
    required this.time,
    required this.price,
    required this.location,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,color: AppColors.primary,),
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppAssets.google,
                      fit: BoxFit.cover,
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.1,),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppFonts.mainText.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Row(
                          children: [
                            Text(
                              company,
                             style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Icon(Icons.access_time,
                                size: screenWidth * 0.035,
                                color: AppColors.primary),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                                  postedTime,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primary,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),
              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButtom(
                      title: "Update",
                      hight: screenHeight * 0.05,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: CustomButtom(
                      title: "Delete",
                      hight: screenHeight * 0.05,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),

              /// Info Container
              InfoContainer(
                category: category,
                time: time,
                price: price,
                location: location,
              ),


              SizedBox(height: screenHeight * 0.03),
              Text(
                "Service Description",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                    ),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
