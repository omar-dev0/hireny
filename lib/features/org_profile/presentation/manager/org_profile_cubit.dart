import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/org_profile/domain/entities/org_post_entity.dart';
import 'package:hireny/features/org_profile/domain/entities/org_profile_entity.dart';
import 'package:hireny/features/org_profile/domain/entities/org_review_entity.dart';
import 'package:hireny/features/org_profile/domain/usecases/add_review.dart';
import 'package:hireny/features/org_profile/domain/usecases/get_org_profile.dart';
import 'package:hireny/features/org_profile/domain/usecases/get_posts.dart';
import 'package:hireny/features/org_profile/domain/usecases/get_reviews.dart';
import 'package:injectable/injectable.dart';

import 'org_profile_states.dart';

@injectable
class OrgProfileCubit extends Cubit<OrgProfileStates> {
  final GetOrgProfile profile;
  final AddReview addReviewUseCase;
  final GetReviews getReviewsUseCase;
  final GetPosts getPostsUseCase;
  TextEditingController reviewController = TextEditingController();

  OrgProfileEntity? profileModel;
  List<OrgPostCardEntity> posts = [];
  List<OrgReviewEntity> reviews = [];

  OrgProfileCubit(
    this.profile,
    this.addReviewUseCase,
    this.getReviewsUseCase,
    this.getPostsUseCase,
  ) : super(InitialState());

  Future<void> loadProfile(int orgID) async {
    emit(LoadingState());
    try {
      profileModel = await profile.call(1);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState("Failed to load course_detailes: ${e.toString()}"));
    }
  }

  // Load posts
  Future<void> loadPosts() async {
    emit(LoadingState());
    try {
      posts = await getPostsUseCase.call(1);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState("Failed to load posts: ${e.toString()}"));
    }
  }

  // Load reviews
  Future<void> loadReviews() async {
    try {
      reviews = await getReviewsUseCase.call(2);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState("Failed to load reviews: ${e.toString()}"));
    }
  }

  Future<void> addReview() async {
    String reviewContent = reviewController.text.trim();

    if (reviewContent.isNotEmpty) {
      try {
        await addReviewUseCase.call(reviewContent);
        await loadReviews();
        print("Fetched Reviews:");
        for (var review in reviews) {
          print(
            "Review by ${review.owner} at ${review.publishedTime}: ${review.content}",
          );
        }
        emit(SuccessState());
        reviewController.clear();
      } catch (e) {
        emit(ErrorState("Failed to add review: ${e.toString()}"));
      }
    } else {
      emit(ErrorState('Please write a review before posting'));
    }
  }
}
