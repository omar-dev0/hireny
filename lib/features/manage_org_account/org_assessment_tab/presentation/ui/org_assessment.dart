import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';

class OrgAssessment extends StatelessWidget {
  const OrgAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("Assessments",style:theme.textTheme.titleLarge?.copyWith(
            color: AppColors.primary
        ),),
        centerTitle:true,
      ),
      // todo drawer color
      drawer: Center(),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 16,),
            Expanded(child: ListView.separated(
                itemBuilder: (context,index)=>Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(16),
                      color:AppColors.subPrimary
                  ),child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Flutter Assessment",style:theme.textTheme.bodyLarge,),
                          SizedBox(width: 8,),
                          Text("20m",style:theme.textTheme.bodySmall,),
                          Icon(Icons.alarm,color: AppColors.primary,size: 20,),
                          Spacer(),
                          SizedBox(
                            height: 30,
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius:BorderRadius.circular(16))
                              ),
                              onPressed: (){},
                              child: Text("completed",style:theme.textTheme.labelMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500
                              ),)),),
                        ],),
                      Row(
                        children: [
                          Icon(Icons.corporate_fare_outlined,color: AppColors.primary,),
                          SizedBox(width: 8,),
                          Text("Google",style:theme.textTheme.bodySmall,),

                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Start Time : 2022-10-2",style:theme.textTheme.bodySmall,),
                          Text("End Time : 2022-10-2",style:theme.textTheme.bodySmall,),

                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("0/15",style:theme.textTheme.bodySmall,),

                        ],),
                    ],
                  ),
                ),
                ),
                separatorBuilder: (context,index)=>SizedBox(height: 8,),
                itemCount: 3)),
          ],
        ),
      ),
    );
  }
}
