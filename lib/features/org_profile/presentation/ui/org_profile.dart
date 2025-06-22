import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_cubit.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_states.dart';
import 'package:hireny/features/org_profile/presentation/ui/company_info.dart';
import 'package:hireny/features/org_profile/presentation/ui/widget/post%20_card.dart';
import 'package:hireny/features/org_profile/presentation/ui/widget/review_card.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class OrgProfile extends StatefulWidget {
  const OrgProfile({super.key});

  @override
  State<OrgProfile> createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  late OrgProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<OrgProfileCubit>();
    cubit.loadProfile(1);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: AppColors.grey.withOpacity(.05),
                pinned: true,
                expandedHeight: 280,
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
                                  Icons.corporate_fare,
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
                          "Corporate fare",
                          style: theme.headlineMedium!.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.groups,
                                    size: 30,
                                    color: AppColors.primary,
                                  ),
                                  Text("12", style: theme.labelLarge),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.work,
                                    size: 30,
                                    color: AppColors.primary,
                                  ),
                                  Text("12", style: theme.labelLarge),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.forum,
                                    size: 30,
                                    color: AppColors.primary,
                                  ),
                                  Text("12", style: theme.labelLarge),
                                ],
                              ),
                            ],
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
                      Tab(text: "Posts"),
                      Tab(text: "Reviews"),
                      Tab(text: "Overview"),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: [
                ListView.separated(
                  itemBuilder: (context, index) =>
                      InkWell(onTap: () {}, child: PostCard()),
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: 4,
                ),
                BlocBuilder<OrgProfileCubit, OrgProfileStates>(
                  builder: (context, state) {
                    return ReviewCard(profileCubit: cubit);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Text(
                        "Description",
                        style: theme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "We are a leading tech recruitment platform that connects top talent with companies around the world. "
                            "Our mission is to streamline hiring with AI-driven solutions. We value innovation, transparency, and growth.",
                        style: theme.bodyMedium,
                      ),
                      const SizedBox(height: 15),
                      CompanyInfoCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
