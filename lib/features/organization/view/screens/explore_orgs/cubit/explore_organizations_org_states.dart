import 'package:hireny/features/organization/domain/modules/organization.dart';
import 'package:hireny/features/organization/domain/modules/seeker.dart';
import 'package:hireny/features/seeker/domain/modules/org_post.dart';

abstract class ExploreOrganizationsOrgState {}

class ExploreOrganizationsOrgInitial extends ExploreOrganizationsOrgState {
}

class ExploreOrganizationsOrgLoading extends ExploreOrganizationsOrgState {
}

class ExploreOrganizationsOrgLoaded extends ExploreOrganizationsOrgState {
  final List<OrgPostOrg> orgs;
  ExploreOrganizationsOrgLoaded({required this.orgs});
}

class ExploreOrganizationsOrgError extends ExploreOrganizationsOrgState {
  final String message;
  ExploreOrganizationsOrgError({required this.message});
}