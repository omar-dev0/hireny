
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/user_profile/presentation/manager/user_profile_states.dart';


class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(InitialState());


}