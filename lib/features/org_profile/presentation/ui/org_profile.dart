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
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child:
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section header with decorative element
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Description",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Content with improved readability
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "We are a leading tech recruitment platform that connects top talent with companies around the world. "
                                "Our mission is to streamline hiring with AI-driven solutions. We value innovation, transparency, and growth.",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Assuming CompanyInfoCard is a custom widget
                         CompanyInfoCard(),
                      ],
                    ),
                  ),
                ),              ],
            ),
          ),
        ),
      ),
    );
  }
}
