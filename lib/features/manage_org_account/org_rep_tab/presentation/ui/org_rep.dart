import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';

class OrgRep extends StatelessWidget {
  const OrgRep({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("Organization representatives",style:theme.textTheme.titleLarge?.copyWith(
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
            SizedBox(child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppColors.primary,
                   shape: ContinuousRectangleBorder(
                       borderRadius:BorderRadius.circular(16))
                 ),
                onPressed: (){},
                child: Text("add admin",style:theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500
                ),)),),
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
                        Text("Ganna Ahmed",style:theme.textTheme.bodyLarge,),
                        Icon(Icons.delete,color: AppColors.red,),
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("email@gmail.com",style:theme.textTheme.bodySmall,),

                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Text("join date : 2022-10-2",style:theme.textTheme.bodySmall,),

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
