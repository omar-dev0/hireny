import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/show_admin/presentation/manager/admin_states.dart';
import 'package:hireny/utils/widgets/custom_admin_drawer.dart';
import 'package:hireny/utils/widgets/custom_appbar.dart';
import '../../../../utils/constants/app_colors.dart';
import '../manager/admin_cubit.dart';

class ShowAdmins extends StatefulWidget {
  const ShowAdmins({super.key});

  @override
  State<ShowAdmins> createState() => _ShowAdminsState();
}

class _ShowAdminsState extends State<ShowAdmins> {
  late AdminCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AdminCubit>();
    cubit.loadAdmins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(title: 'Admins'),
      drawer: CustomAdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.add, color: AppColors.white, size: 20),
                      SizedBox(width: 4),
                      Text(
                        "Add new admin",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<AdminCubit, AdminStates>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ErrorState) {
                    return Center(
                      child: Text(state.message ?? "An error occurred"),
                    );
                  } else if (state is SuccessState) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 120,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppColors.subPrimary,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.admins[index].adminName,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge!.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    cubit.admins[index].adminEmail,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: AppColors.grey),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    cubit.admins[index].adminDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: AppColors.grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.edit,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  cubit.deleteCourse(cubit.admins[index]);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: 16),
                      itemCount: cubit.admins.length,
                    );
                  }
                  return Center(child: Text('No data available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
