import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';

class ServiceRequest extends StatelessWidget {
  const ServiceRequest({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("Service Request",style:theme.textTheme.titleLarge?.copyWith(
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
                  height: 90,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Logo Design",style:theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500
                          ),),
                          Icon(Icons.delete,color: AppColors.red,),
                        ],),
                      Row(
                        children: [
                          Text("Price : ",style:theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500
                          ),),
                          Text("2",style:theme.textTheme.bodySmall,),

                        ],),
                      Row(
                        children: [
                          Text("Requested at : ",style:theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500
                          ),),
                          Text("july 22,2002,12:12 AM",style:theme.textTheme.bodySmall,),

                        ],)
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
