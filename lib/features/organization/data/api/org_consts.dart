abstract class OrgConst {
  static const String getAllSeekers = '/api/auth/get-all-seekers/';
  static const String getNotAppliedServicePosts = '/api/posts/services/not-applied';
  static const String getAllOrganizations = '/api/auth/get-all-organizations/';
  static String applyToService(int serviceId) => '/api/applications/services/$serviceId/apply/';


}