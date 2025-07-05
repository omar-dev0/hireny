import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/org_profile/domain/models/reviews.dart';
import 'package:hireny/features/org_profile/domain/repo_contract/org_profile_repo_contratc.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_states.dart';
import 'package:hireny/features/seeker/domain/modules/job_details.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrgProfileCubit extends Cubit<OrgProfilleState> {
  OrgProfileRepoContract orgProfileRepoContract;
  @factoryMethod
  OrgProfileCubit(this.orgProfileRepoContract) : super(InintOrg());
  List<ReviewModel> reviews = [];
  List<JobDetailsModel> posts = [];
  TextEditingController reviewController = TextEditingController();

  Future<void> getOrgReviews(num id) async {
    try {
      emit(LoadingReviews());
      final result = await orgProfileRepoContract.getOrgReviews(id);
      switch (result) {
        case null:
          {
            emit(ErrorLoadedReviews('can\' load profile data'));
          }
        case Success<List<ReviewModel>>():
          {
            reviews = result.response ?? [];
            emit(SuccessLoadedReviews());
          }
        case Error<List<ReviewModel>>():
          {
            emit(ErrorLoadedReviews('can\' load profile data'));
          }
      }
    } catch (e) {
      emit(ErrorLoadedReviews(e.toString()));
    }
  }

  Future<void> getOrgJobs(num id) async {
    try {
      emit(LoadingOrgJobs());
      final result = await orgProfileRepoContract.getOrgJobs(id);
      switch (result) {
        case null:
          {
            emit(ErrorLoadedPosts('can\' load profile data'));
          }
        case Success<List<JobDetailsModel>>():
          {
            posts = result.response ?? [];
            emit(SuccessLoadedPosts());
          }
          throw UnimplementedError();
        case Error<List<JobDetailsModel>>():
          {
            emit(ErrorLoadedPosts('can\' load profile data'));
          }
      }
    } catch (e) {
      emit(ErrorLoadedPosts(e.toString()));
    }
  }

  Future<void> addOrgReview(num id, String review) async {
    try {
      emit(LoadingAddOrgReview());
      final result = await orgProfileRepoContract.createReview(review, id);
      switch (result) {
        case null:
          {
            emit(HideDialogOrgProfile());
            emit(ErrorAddOrgReview('can\' load profile data'));
          }
        case Success<ReviewModel>():
          {
            emit(HideDialogOrgProfile());
            reviews.add(result.response!);
            emit(SuccessAddOrgReview());
          }
        case Error<ReviewModel>():
          {
            emit(HideDialogOrgProfile());
            if (result.error.toString().contains('299')) {
              emit(ErrorAddOrgReview('your review has bad words'));
              return;
            }
            emit(ErrorAddOrgReview('can\' load profile data'));
          }
      }
    } catch (e) {
      emit(HideDialogOrgProfile());
      emit(ErrorAddOrgReview('can\' load profile data'));
    }
  }

  Future<void> deleteOrgReview(num id) async {
    try {
      emit(LoadingAddOrgReview());
      final result = await orgProfileRepoContract.deleteReview(id);
      switch (result) {
        case null:
          {
            emit(HideDialogOrgProfile());
            emit(ErrorAddOrgReview('can\' load profile data'));
          }
        case Success<void>():
          {
            emit(HideDialogOrgProfile());
            int index = reviews.indexOf(ReviewModel(id: id));
            if (index != -1) {
              reviews.removeAt(index);
            }
            emit(SuccessAddOrgReview());
          }
        case Error<void>():
          {
            emit(HideDialogOrgProfile());
            if (result.error.toString().contains('299')) {
              emit(ErrorAddOrgReview('your review has bad words'));
              return;
            }
            emit(ErrorAddOrgReview('can\' load profile data'));
          }
      }
    } catch (e) {
      emit(HideDialogOrgProfile());
      emit(ErrorAddOrgReview('can\' load profile data'));
    }
  }

  Future<void> updateReview(num id, String review) async {
    try {
      emit(LoadingAddOrgReview());
      final result = await orgProfileRepoContract.updateReview(review, id);
      switch (result) {
        case null:
          {
            emit(HideDialogOrgProfile());
            emit(ErrorAddOrgReview('can\' load profile data'));
          }
        case Success<void>():
          {
            emit(HideDialogOrgProfile());
            int index = reviews.indexOf(ReviewModel(id: id));
            if (index != -1) {
              reviews[index].message = review;
            }

            emit(SuccessAddOrgReview());
          }
        case Error<void>():
          {
            emit(HideDialogOrgProfile());
            if (result.error.toString().contains('299')) {
              emit(ErrorAddOrgReview('your review has bad words'));
              return;
            }
            emit(ErrorAddOrgReview('can\' load profile data'));
          }
      }
    } catch (e) {
      emit(HideDialogOrgProfile());
      emit(ErrorAddOrgReview('can\' load profile data'));
    }
  }
}
