import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/features/services/presentation/manager/service_org_cubit.dart';
import 'package:hireny/features/services/presentation/ui/service_post.dart';
import 'package:hireny/features/services/presentation/ui/widgets/info_row.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/widgets/custom_buttom.dart';
import '../../../../utils/di/di.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServiceResponse serviceObj;

  ServiceDetailsScreen({
    super.key,
    required this.serviceObj,
  });



  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final serviceCubit =context.read<ServiceOrgCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: AppColors.primary),
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
              /// 🔹 Header row with logo and info
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppAssets.google,
                      fit: BoxFit.cover,
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.1,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceObj.serviceTitle,
                          style: AppFonts.mainText.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Row(
                          children: [
                            Text(
                              serviceObj.companyName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Icon(
                              Icons.access_time,
                              size: screenWidth * 0.035,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              serviceCubit.formatCreatedAt(serviceObj.createdAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              /// 🔹 Buttons (Update & Delete)
              Row(
                children: [
                  Expanded(
                    child: CustomButtom(
                      title: "Update",
                      hight: screenHeight * 0.05,
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(
                          builder:
                              (_) =>BlocProvider(
                            create: (_) =>getIt.get<ServiceOrgCubit>()..setFields(serviceObj),
                            child: ServicePost(isUpdate: true,service: serviceObj,),
                          ),
                        ));
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: CustomButtom(
                      title: "Delete",
                      hight: screenHeight * 0.05,
                      onPressed: () async {
                        await serviceCubit.deleteService(serviceObj.id);
                        Navigator.pop(context, 'deleted'); // ✅ Return to previous screen with flag
                      },
                    )
                    ,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),

              /// 🔹 Info Row
              InfoContainer(
                category: serviceObj.city,
                time: serviceCubit.formatCreatedAt(serviceObj.createdAt),
                price: serviceObj.salary,
                location: "${serviceObj.country},${serviceObj.city}",
              ),

              SizedBox(height: screenHeight * 0.03),

              /// 🔹 Service Description
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
                    serviceObj.serviceDescription,
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
