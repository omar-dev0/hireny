import '../../../../domain/modules/org_post.dart';

abstract class OrgPostState {}

class OrgPostInitial extends OrgPostState {}

class OrgPostLoading extends OrgPostState {}

class OrgPostLoaded extends OrgPostState {
  final List<OrgPost> orgPosts;
  OrgPostLoaded({required this.orgPosts});
}

class OrgPostError extends OrgPostState {
  final String message;
  OrgPostError({required this.message});
}
