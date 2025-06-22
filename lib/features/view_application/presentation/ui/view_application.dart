import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/view_application/domain/entities/application_entity.dart';
import 'package:hireny/features/view_application/presentation/manager/app_cubit.dart';
import 'package:hireny/features/view_application/presentation/manager/app_states.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../utils/widgets/custom_appbar.dart';
import '../../../user_accout/widgets/side_bar.dart';

class ViewApplication extends StatefulWidget {
  const ViewApplication({super.key});

  @override
  State<ViewApplication> createState() => _ViewApplicationState();
}

class _ViewApplicationState extends State<ViewApplication> {
  late AppCubit cubit ;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AppCubit>();
    cubit.loadApplications();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: SideBar(index: 2,),
      appBar:CustomAppbar(title: "My Applications",),
      body: Padding(padding: EdgeInsets.all(16),child: Column(
      children: [
        Expanded(child:
        BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            if( state is LoadingState){
              return Center(child: CircularProgressIndicator());
            }else if(state is ErrorState){
              return Center(child: Text(state.message ?? "An error occurred"));

            }else if(state is SuccessState){
              return ListView.separated(
                itemBuilder: (context,index)=>Container(
                    width: double.infinity,
                    height: 180,
                    padding:const EdgeInsets.all(16.0) ,
                    decoration: BoxDecoration(
                      color: AppColors.subPrimary,
                      borderRadius:BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary,width: 2),
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cubit.applications[index].applicationType,style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary
                                ),),
                                SizedBox(width: 16,),
                                Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: cubit.applications[index].status == AppStatus.pending?AppColors.grey.withOpacity(0.7):
                                    cubit.applications[index].status == AppStatus.rejected?AppColors.red:
                                    cubit.applications[index].status == AppStatus.approved?AppColors.green:AppColors.primary,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child:Center(child: Text(cubit.applications[index].status.name,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold
                                  ),)),
                                )
                              ],
                            ),
                            SizedBox(height: 16,),
                            Row(
                              children: [
                                Icon(Icons.corporate_fare,color: AppColors.primary,size: 30,),
                                SizedBox(width: 16,),
                                Text(cubit.applications[index].companyName,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.primary
                                ),),
                                Spacer(),
                                cubit.applications[index].status.name == AppStatus.pending.name?
                                InkWell(
                                  onTap: (){
                                    cubit.deleteCourse(cubit.applications[index]);
                                  },
                                  child: Icon(Icons.delete,color: AppColors.primary,size: 30,)):SizedBox(),

                              ],
                            ),
                            SizedBox(height:40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cubit.applications[index].appliedDate,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.grey
                                ),),
                                SizedBox(width: 8,),
                                Text(cubit.applications[index].deadlineDate,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.grey
                                ),)
                              ],)
                          ],
                        ),

                      ],
                    )
                ),
                separatorBuilder: (context,index)=>SizedBox(height: 16,),
                itemCount: cubit.applications.length,

              );

            }
            return Center(child: Text('No data available'));
          },
))

      ],
    ),),
    );
  }
}
