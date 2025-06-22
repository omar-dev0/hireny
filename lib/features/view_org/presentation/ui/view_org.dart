import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/view_org/presentation/manager/org_cubit.dart';
import 'package:hireny/features/view_org/presentation/manager/org_state.dart';
import 'package:hireny/utils/app_assets.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../utils/widgets/custom_appbar.dart';

class ViewOrg extends StatefulWidget {
  const ViewOrg({super.key});

  @override
  State<ViewOrg> createState() => _ViewOrgState();
}

class _ViewOrgState extends State<ViewOrg> {
  late OrgCubit cubit ;

  @override
  void initState() {
    super.initState();
    cubit = context.read<OrgCubit>();
    cubit.loadOrg();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(title: "Verify Organization",),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child:
            BlocBuilder<OrgCubit, OrgStates>(
              builder: (context, state) {
                if(state is LoadingState){
                  return Center(child: CircularProgressIndicator());
                }else if(state is ErrorState){
                  return Center(child: Text(state.message ?? "An error occurred"));
                }else if(state is SuccessState){
                  return ListView.separated(
                    itemBuilder: (context,index)=>Container(
                      width: double.infinity,
                      height: 130,
                      padding:const EdgeInsets.all(16.0) ,
                      decoration: BoxDecoration(
                        color: AppColors.subPrimary,
                        borderRadius:BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primary,width: 2),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: 20,child: Image.asset(AppAssets.logo),backgroundColor: AppColors.white,),
                                  SizedBox(width: 16,),
                                  Text(cubit.org[index].orgPresenterName,style: Theme.of(context).textTheme.titleLarge,),
                                ],
                              ),
                              SizedBox(width: 16,),
                              Text(cubit.org[index].orgEmail,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppColors.grey
                              ),),
                              SizedBox(width: 16,),
                              Text(cubit.org[index].joinDate,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppColors.grey
                              ),),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                              onTap:()=>{
                                cubit.changeState(cubit.org[index],false)
                              } ,
                              child: Icon(Icons.close,color: AppColors.primary,size: 30,)),
                          SizedBox(width: 8,),
                          InkWell(
                              onTap:()=>{
                                cubit.changeState(cubit.org[index],true)
                              } ,
                              child: Icon(Icons.check,color: AppColors.primary,size: 30,)),



                        ],
                      ),
                    ),
                    separatorBuilder: (context,index)=>SizedBox(height: 16,),
                    itemCount: cubit.org.length,

                  );

                }
                return Center(child: Text('No data available'));
  },
))

          ],
        ),
      ),

    );
  }
}
