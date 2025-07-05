import 'package:hireny/features/organization/domain/modules/seeker.dart';

abstract class SeekerPostState {}

class SeekerPostInitial extends SeekerPostState {
}

class SeekerPostLoading extends SeekerPostState {
}

class SeekerLoaded extends SeekerPostState {
  final List<SeekerModel> seekers;
  SeekerLoaded({required this.seekers});
}

class SeekerPostError extends SeekerPostState {
  final String message;
  SeekerPostError({required this.message});
}