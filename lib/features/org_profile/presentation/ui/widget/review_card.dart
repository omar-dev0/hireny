import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

import 'package:hireny/features/org_profile/presentation/manager/org_profile_cubit.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_states.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class ReviewCard extends StatefulWidget {
  final OrgProfileCubit profileCubit;

  const ReviewCard({super.key, required this.profileCubit});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late OrgProfileCubit cubit;

  @override
  void initState() {
    cubit = widget.profileCubit;
    super.initState();
    cubit.loadReviews();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgProfileCubit, OrgProfileStates>(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: cubit.reviews.length + 1,
          itemBuilder: (context, index) {
            // Add Review Input at the end
            if (index == cubit.reviews.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.subPrimary,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add a Review",
                              style: AppFonts.mainText.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              minLines: 3,
                              maxLines: 5,
                              hint: "Write your thoughts here...",
                              controller: cubit.reviewController,
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  final text = cubit.reviewController.text.trim();
                                  if (text.isNotEmpty) {
                                    cubit.addReview();
                                    cubit.reviewController.clear();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Review cannot be empty")),
                                    );
                                  }
                                },
                                child: const Text("Post Review", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

            // Review Card
            final review = cubit.reviews[index];
            final initials = review.owner.isNotEmpty
                ? review.owner.trim().split(" ").map((e) => e[0]).take(2).join().toUpperCase()
                : "U";

            return FadeInUp(
              duration: Duration(milliseconds: 300 + (index * 150)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.subPrimary,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/comment.png", width: 28),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                // border: Border.all(color: AppColors.grey),
                              ),
                              child: Text(
                                review.content,
                                style: AppFonts.textFieldStyle.copyWith(color: AppColors.black.withOpacity(0.8)),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.primary,
                                  child: Text(
                                    initials,
                                    style: AppFonts.mainText.copyWith(
                                      color: AppColors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Text(
                                  review.owner,
                                  style: AppFonts.mainText.copyWith(fontSize: 16, color: AppColors.black),
                                ),
                                const Spacer(),
                                Text(
                                  review.publishedTime,
                                  style: AppFonts.textFieldStyle.copyWith(
                                    color: AppColors.grey.withOpacity(0.8),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
