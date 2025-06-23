import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("Reviews",style:theme.textTheme.titleLarge?.copyWith(
            color: AppColors.primary
        ),),
        centerTitle:true,
      ),
      body:  ListView.separated(
          itemBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.subPrimary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),

                child:
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: Icon(Icons.corporate_fare_outlined,color: AppColors.primary,),
                          ),
                          SizedBox(width: 8,),
                          Text("company",style:theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500
                          )),
                          SizedBox(width: 16,),
                          Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.1),
                                borderRadius:BorderRadius.circular(16)
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("20m",style:theme.textTheme.titleSmall?.copyWith(
                                  color: AppColors.grey
                                )),
                                SizedBox(width: 8,),
                                Icon(Icons.schedule,color: AppColors.grey,)
                              ],
                            ),
                          )

                        ],
                      ),
                      SizedBox(height: 16,),
                      Text("Lorem Ipsum is simply dummy text of the printing and"
                          " typesetting industry. Lorem Ipsum has been the industry's"
                          " standard dummy text ever since the 1500s, when "
                          "an unknown printer took a galley of type and scrambled "
                        ,style: theme.textTheme.bodyLarge,)
                    ],
                  ),
                )
            ),
          ),
          separatorBuilder: (context,index)=>SizedBox(height: 16,),
          itemCount: 3),
    );
  }
}
