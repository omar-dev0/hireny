abstract class ApiConst {
  static const String reg = '/api/auth/register/';
  static const String login = '/api/auth/login/';

  static const String getUserInfo = '/api/auth/get-user-details/';
  static const String updateUserInfo = "/api/auth/update-user-details/";
  static const String changePass = "/api/auth/change-password/";

  static const String verifyEmail = '/api/auth/send-otp/';
  static const String verifyOtp = '/api/auth/verify-otp/';
  static const String resetPassword = '/api/auth/reset-password/';

  static const String getAssessmentDetail = '/api/assessments/assessments/';

  static const String extractJobSeekerInfoModel =
      '/api/AI_models/extract_resume_data/';

  static const String getSeekerAssessments =
      '/api/assessments/assessments/user/';

  static const String submitAssessment =
      '/api/assessments/user-assessments/submit/';

  static String generateResume = '/api/AI_models/download_resume/';
  static String generateCoverLetter = '/api/AI_models/download_cover_letter/';

  static String recommendTitles = '/api/AI_models/recommend_titles/';
  static String fillOrgReg = '/api/AI_models/extract_org_proof_data/';
}
