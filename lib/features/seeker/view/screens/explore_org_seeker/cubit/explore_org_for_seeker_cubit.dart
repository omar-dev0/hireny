import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../result.dart';
import '../../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../domain/modules/org_post.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'explore_org_for_seeker_states.dart';

@injectable
class OrgPostCubit extends Cubit<OrgPostState> {
  final SeekerRepository seekerRepository;

  OrgPostCubit(this.seekerRepository) : super(OrgPostInitial());

  Future<void> fetchAllOrganizations() async {
    emit(OrgPostLoading());
    try {
      final result = await seekerRepository.getAllOrganizations();

      if (result is Success<List<OrgPost>>) {
        AppSharedData.orgPosts = result.response ?? [];

        emit(OrgPostLoaded(orgPosts: result.response ?? []));
      } else if (result is Error<List<OrgPost>>) {
        emit(OrgPostError(message: result.error ?? "An error occurred"));
      }
    } catch (e) {
      emit(OrgPostError(message: e.toString()));
    }
  }

  void filterOrgPosts(String query) {
    if (query.isEmpty) {
      emit(OrgPostLoaded(orgPosts: AppSharedData.orgPosts));
      return;
    }

    final filteredList = AppSharedData.orgPosts
        .where((orgPost) =>
        orgPost.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(OrgPostLoaded(orgPosts: filteredList));
  }
}