import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/org_entity.dart';
import '../../domain/usecases/show_org.dart';
import '../../domain/usecases/verify_org.dart';
import 'org_state.dart';

@injectable
class OrgCubit extends Cubit<OrgStates> {
  final VerifyOrg verifyOrg;
  final ShowOrg listOrg;
  List<OrgEntity> org = [];

  @factoryMethod
  OrgCubit(this.verifyOrg, this.listOrg) : super(InitialState());

  Future<void> loadOrg() async {
    try {
      print("calling loadOrg");
      emit(LoadingState());
      org = await listOrg.call();
      emit(SuccessState()); // Pass org list to SuccessState
    } catch (e) {
      emit(ErrorState("Failed to load courses"));
    }
  }

  Future<void> changeState(OrgEntity org, bool isApproved) async {
    try {
      print("-> Starting changeState()");
      await verifyOrg.call(org, isApproved);
      print("-> verifyOrg done");

      await loadOrg();
      print("-> loadOrg done");

      emit(SuccessState());
    } catch (e) {
      print("-> Error in changeState: $e");
      emit(ErrorState(e.toString()));
    }
  }
}


