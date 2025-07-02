import 'package:flutter/material.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/manage_org_account/reviews_tab/presentation/ui/widget/review_dialog.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../../../../routes/page_route.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScreen(
        title: "Reviews",
        drawer: const SideBarScreen(currentRoute: PagesRoute.orgReviewForOrg),
        body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final fullComment = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                  'It has survived not only five centuries, but also the leap into electronic typesetting. '
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ';

              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => ReviewDialog(comment: fullComment, personName: 'person name' , ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightPurple,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/comment.png", width: 30),
                      const SizedBox(height: 12),

                      /// This still shows short preview
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          fullComment,
                          style: AppFonts.textFieldStyle,
                          maxLines: 4, // preview only
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              'CP',
                              style: AppFonts.mainText.copyWith(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Company Name',
                            style: AppFonts.mainText.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
