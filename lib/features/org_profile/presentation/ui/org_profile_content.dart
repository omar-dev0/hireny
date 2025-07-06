import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/org_profile/presentation/ui/widget/review_card.dart';

import '../../../../routes/page_route.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/data_shared/shared_const_api.dart';
import '../../../seeker/domain/modules/org_post.dart';
import '../manager/org_profile_cubit.dart';
import '../manager/org_profile_states.dart';
import 'company_info.dart';

class OrgProfileContent extends StatefulWidget {
  final OrgPost orgPost;
  const OrgProfileContent({super.key, required this.orgPost});

  @override
  State<OrgProfileContent> createState() => _OrgProfileContentState();
}

class _OrgProfileContentState extends State<OrgProfileContent> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OrgProfileCubit>();
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: NestedScrollView(
        headerSliverBuilder:
            (context, _) => [
              SliverAppBar(
                backgroundColor: AppColors.grey.withOpacity(.05),
                pinned: true,
                leading: const SizedBox(),
                expandedHeight: 280,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          FadeInDown(
                            duration: const Duration(milliseconds: 500),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                    child: Image.network(
                                      '${ApiShared.baseUrl}${widget.orgPost.photo}',
                                      width:
                                          MediaQuery.sizeOf(context).width * .2,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                          .1,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) {
                                        return Image.asset(
                                          AppAssets.org_logo,
                                        ); // Fallback to placeholder if image fails to load
                                      },
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chat,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeIn(
                            duration: const Duration(milliseconds: 700),
                            child: Text(
                              widget.orgPost.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.headlineMedium!.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SlideInUp(
                            duration: const Duration(milliseconds: 800),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStat(
                                  theme,
                                  Icons.groups,
                                  widget.orgPost.organizationSize,
                                ),
                                _buildStat(theme, Icons.work, '12'),
                                _buildStat(theme, Icons.forum, "12"),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                    overlayColor: WidgetStateProperty.all(Colors.white),
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
              itemBuilder: (_, index) {
                final post = cubit.posts[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PagesRoute.jobDetailes,
                      arguments: cubit.posts[index].id,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.05),
                          blurRadius: 20,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with company info
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.network(
                                  '${ApiShared.baseUrl}${post.companyLogo}',
                                  width: MediaQuery.sizeOf(context).width * .2,
                                  height:
                                      MediaQuery.sizeOf(context).height * .1,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return Image.asset(
                                      AppAssets.org_logo,
                                    ); // Fallback to placeholder if image fails to load
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.companyName,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Job title
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            post.jobTitle,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Job details tags
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildDetailPill(Icons.work_outline, 'Commerce'),
                              _buildDetailPill(
                                Icons.access_time_outlined,
                                post.jobType,
                              ),
                              _buildDetailPill(
                                Icons.attach_money_outlined,
                                '${post.minSalary} - ${post.maxSalary} ${post.currency}',
                              ),
                              _buildDetailPill(
                                Icons.location_on_outlined,
                                post.country,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Divider
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            height: 1,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 8),
              itemCount: cubit.posts.length,
            ),
            BlocBuilder<OrgProfileCubit, OrgProfilleState>(
              builder: (context, state) {
                return ReviewCardOrg(
                  profileCubit: cubit,
                  Id: widget.orgPost.id,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: theme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "We are a leading tech recruitment platform that connects top talent with companies around the world. Our mission is to streamline hiring with AI-driven solutions. We value innovation, transparency, and growth.",
                      style: theme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),
                    CompanyInfoCard(
                      infoItems: [
                        {
                          "icon": Icons.person_outline_rounded,
                          "label": "CEO",
                          "value": widget.orgPost.ceoName,
                        },
                        {
                          "icon": Icons.calendar_month_rounded,
                          "label": "Founded",
                          "value": widget.orgPost.establishmentYear.toString(),
                        },
                        {
                          "icon": Icons.people_alt_rounded,
                          "label": "Employees",
                          "value": widget.orgPost.organizationSize,
                        },
                        {
                          "icon": Icons.rocket_launch_rounded,
                          "label": "Industry",
                          "value": widget.orgPost.industry,
                        },
                        {
                          "icon": Icons.location_pin,
                          "label": "Location",
                          "value":
                              '${widget.orgPost.country}, ${widget.orgPost.city}',
                        },
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(TextTheme theme, IconData icon, String value) {
    return Column(
      children: [
        Icon(icon, size: 30, color: AppColors.primary),
        Text(value, style: theme.labelLarge),
      ],
    );
  }

  Widget _buildDetailPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
