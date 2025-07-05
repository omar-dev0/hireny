abstract class OrgProfilleState {}

class InintOrg extends OrgProfilleState {}

class SuccessLoadedReviews extends OrgProfilleState {}

class ErrorLoadedReviews extends OrgProfilleState {
  final String error;
  ErrorLoadedReviews(this.error);
}

class LoadingReviews extends OrgProfilleState {}

class LoadingOrgJobs extends OrgProfilleState {}

class SuccessLoadedPosts extends OrgProfilleState {}

class ErrorLoadedPosts extends OrgProfilleState {
  final String error;
  ErrorLoadedPosts(this.error);
}

class LoadingAddOrgReview extends OrgProfilleState {}

class SuccessAddOrgReview extends OrgProfilleState {}

class HideDialogOrgProfile extends OrgProfilleState {}

class ErrorAddOrgReview extends OrgProfilleState {
  final String error;
  ErrorAddOrgReview(this.error);
}
