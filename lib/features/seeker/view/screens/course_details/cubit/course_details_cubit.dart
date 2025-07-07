import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/org_profile/domain/models/reviews.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/modules/course.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';

import 'course_details_states.dart';

@injectable
class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  final SeekerRepository seekerRepository;
  List<ReviewModel> reviews = [];
  Course? course;

  CourseDetailsCubit(this.seekerRepository) : super(CourseDetailsInitial());

  TextEditingController reviewController = TextEditingController();

  Future<void> fetchCourseDetails(int courseId) async {
    emit(CourseDetailsLoading());
    try {
      final result = await seekerRepository.getCourseDetails(courseId);

      if (result is Success<Course>) {
        course = result.response;
        emit(CourseDetailsLoaded(courseDetails: result.response));
      } else if (result is Error<Course>) {
        emit(CourseDetailsError(message: result.error ?? "An error occurred"));
      }
    } catch (e) {
      emit(CourseDetailsError(message: e.toString()));
    }
  }

  Future<void> addCourseReview(num id, String review) async {
    try {
      final result = await seekerRepository.createReview(review, id);
      switch (result) {
        case null:
          {
            emit(ErrorAddCourseReview('can\' load profile data'));
          }
        case Success<ReviewModel>():
          {
            reviews.add(result.response!);
            emit(SuccessAddCourseReview());
          }
        case Error<ReviewModel>():
          {
            if (result.error.toString().contains('299')) {
              emit(ErrorAddCourseReview('your review has bad words'));
              return;
            }
            emit(ErrorAddCourseReview('can\' load profile data'));
          }
      }
    } catch (e) {
      emit(ErrorAddCourseReview('can\' load profile data'));
    }
  }

  Future<void> deleteCourseReview(num id) async {
    try {
      emit(LoadingAddCourseReview());
      final result = await seekerRepository.deleteReview(id);
      switch (result) {
        case null:
          {
            emit(HideDialogCourseReview());
            emit(ErrorAddCourseReview('can\' load profile data'));
          }
        case Success<void>():
          {
            int index = reviews.indexOf(ReviewModel(id: id));
            if (index != -1) {
              reviews.removeAt(index);
            }
            emit(SuccessAddCourseReview());
          }
        case Error<void>():
          {
            if (result.error.toString().contains('299')) {
              emit(ErrorAddCourseReview('your review has bad words'));
              return;
            }
            emit(ErrorAddCourseReview('can\' load profile data'));
          }
      }
    } catch (e) {
      emit(ErrorAddCourseReview('can\' load profile data'));
    }
  }

  Future<void> updateReview(num id, String review) async {
    try {
      emit(LoadingAddCourseReview());
      final result = await seekerRepository.updateReview(review, id);
      switch (result) {
        case null:
          {
            emit(ErrorAddCourseReview('can\' load profile data'));
          }
        case Success<void>():
          {
            int index = reviews.indexOf(ReviewModel(id: id));
            if (index != -1) {
              reviews[index].message = review;
            }

            emit(SuccessAddCourseReview());
          }
        case Error<void>():
          {
            if (result.error.toString().contains('299')) {
              emit(ErrorAddCourseReview('your review has bad words'));
              return;
            }
            emit(ErrorAddCourseReview('can\' load profile data'));
          }
      }
    } catch (e) {
      emit(ErrorAddCourseReview('can\' load profile data'));
    }
  }

  Future<void> getCourseReviews(num id) async {
    try {
      emit(LoadReviewCourse());
      final result = await seekerRepository.getReviews(id);
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
}
