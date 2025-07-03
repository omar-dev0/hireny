import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/domain/repo_contract/seeker_repository.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../result.dart';
import '../../../../domain/modules/seeker.dart';
import '../../../../domain/repo_contract/org_repository.dart';
import 'explore_seekers_states.dart';

@injectable
class ExploreSeekersCubit extends Cubit<SeekerPostState> {
  final OrgRepository orgRepository;

  ExploreSeekersCubit(this.orgRepository) : super(SeekerPostInitial());

  Future<void> fetchAllSeekers() async {
    emit(SeekerPostLoading());
    try {
      final Result<List<SeekerModel>> result = await orgRepository.getAllSeekers();

      if (result is Success<List<SeekerModel>>) {
        AppSharedData.seekers = result.response ?? [];

        emit(SeekerLoaded(seekers: result.response ?? []));
      } else if (result is Error<List<SeekerModel>>) {
        emit(SeekerPostError(message: result.error ?? "An unknown error occurred"));
      }
    } catch (e) {
      emit(SeekerPostError(message: e.toString()));
    }
  }

  /// Filter seekers by name or job title based on search query
  void filterSeekers(String query) {
    if (query.isEmpty) {
      emit(SeekerLoaded(seekers: AppSharedData.seekers));
      return;
    }

    final filteredList = AppSharedData.seekers
        .where((seeker) =>
    seeker.user?.firstName?.toLowerCase().contains(query.toLowerCase()) == true ||
        seeker.title?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    emit(SeekerLoaded(seekers: filteredList));
  }
}