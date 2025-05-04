import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_cubit.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_states.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';

import '../../../../../utils/constants/app_colors.dart';

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
    print("Calling");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          BlocBuilder<OrgProfileCubit, OrgProfileStates>(
        builder: (context, state) {
      return
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == cubit.reviews.length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, -6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Write review",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(children: [
                          Expanded(
                            child: CustomTextField(
                              onValidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                  return 'Only alphabets are allowed';
                                }
                                return null;
                              },
                              maxLength: 300,
                              keyboardType: TextInputType.text,
                              minLines: 1,
                              hint: "Write your review here",
                              controller: cubit.reviewController,
                            ),
                          ),
                        ]),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              // Get the review text
                              String reviewContent = cubit.reviewController.text.trim();
                              if (reviewContent.isNotEmpty) {
                                cubit.addReview();
                                print(cubit.reviewController.text);
                                cubit.reviewController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please write a review before posting')),
                                );
                              }
                            },
                            child: Text(
                              "Post Review",
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // Displaying the existing reviews
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, -6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              cubit.reviews[index].owner,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            Text(
                              cubit.reviews[index].publishedTime,
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          cubit.reviews[index].content,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemCount: cubit.reviews.length + 1,
          );
        },
      ),
        ],
      ),
    );
  }
}
