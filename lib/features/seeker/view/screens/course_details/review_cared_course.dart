import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

import 'package:hireny/features/seeker/view/screens/course_details/cubit/course_details_cubit.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../org_profile/presentation/ui/widget/edit_bottom_sheet.dart';
import 'cubit/course_details_states.dart';

class ReviwCardCourse extends StatefulWidget {
  final CourseDetailsCubit courseCubit;
  final num Id;

  const ReviwCardCourse({
    super.key,
    required this.courseCubit,
    required this.Id,
  });

  @override
  State<ReviwCardCourse> createState() => _ReviwCardCourseState();
}

class _ReviwCardCourseState extends State<ReviwCardCourse> {
  late CourseDetailsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = widget.courseCubit;
    cubit.getCourseReviews(widget.Id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        if (state is LoadReviewCourse) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorLoadedReviews) {
          return Center(child: Text(state.error));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: cubit.reviews.isEmpty ? 1 : cubit.reviews.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
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
                              style: AppFonts.mainText.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  final text =
                                      cubit.reviewController.text.trim();
                                  if (text.isNotEmpty) {
                                    cubit.addCourseReview(widget.Id, text);
                                    cubit.reviewController.clear();
                                    setState(() {});
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Review cannot be empty"),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Post Review",
                                  style: TextStyle(color: Colors.white),
                                ),
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

            final review = cubit.reviews[index - 1];
            final initials =
                review.reviewerName?.isNotEmpty == true
                    ? review.reviewerName
                        ?.trim()
                        .split(" ")
                        .map((e) => e[0])
                        .take(2)
                        .join()
                        .toUpperCase()
                    : "U";

            return FadeInUp(
              duration: Duration(milliseconds: 300 + (index * 150)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
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
                              ),
                              child: Text(
                                review.message ?? "",
                                style: AppFonts.textFieldStyle.copyWith(
                                  color: AppColors.black.withOpacity(0.8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.primary,
                                  child: Text(
                                    initials ?? "",
                                    style: AppFonts.mainText.copyWith(
                                      color: AppColors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review.reviewerName ?? "",
                                        style: AppFonts.mainText.copyWith(
                                          fontSize: 16,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Text(
                                        "${review.createdAt?.day}/${review.createdAt?.month}/${review.createdAt?.year}",
                                        style: AppFonts.textFieldStyle.copyWith(
                                          color: AppColors.grey.withOpacity(
                                            0.8,
                                          ),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (review.reviewer == AppSharedData.user?.id)
                                  PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: AppColors.primary,
                                    ),
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        showEditReviewBottomSheet(
                                          onEdit: (val) {
                                            cubit.updateReview(review.id!, val);
                                            setState(() {});
                                          },
                                          context: context,
                                          initialText: review.message ?? "",
                                        );
                                      } else if (value == 'delete') {
                                        cubit.deleteCourseReview(review.id!);
                                        setState(() {});
                                      }
                                    },
                                    itemBuilder:
                                        (context) => const [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Text('Edit'),
                                          ),
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                        ],
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
