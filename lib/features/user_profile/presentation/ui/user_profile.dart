import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/user_profile/presentation/manager/user_profile_cubit.dart';
import 'package:hireny/features/user_profile/presentation/ui/widgets/experience_tab.dart';
import 'package:hireny/features/user_profile/presentation/ui/widgets/general_info.dart';
import 'package:hireny/utils/constants/app_colors.dart';


class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: AppColors.subPrimary,
                pinned: true,
                expandedHeight: 240,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: AppColors.primary,
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 3,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chat,
                              size: 30,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Person's name",
                          style: theme.titleLarge!.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Graphic designer",
                          style: theme.titleMedium!.copyWith(
                            color: AppColors.grey.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: TabBar(
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.primary,
                    labelStyle: theme.labelLarge!.copyWith(fontSize: 18),
                    unselectedLabelStyle: theme.labelLarge!.copyWith(
                      fontSize: 16,
                    ),
                    overlayColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    tabs: const [
                      Tab(text: "Home"),
                      Tab(text: "Info"),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: [
                HomeInfo(),
                GeneralUserInfo()


              ],
            ),
          ),
        ),
      ),
    );
  }
}
