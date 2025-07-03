import '../../../../domain/modules/service.dart';

abstract class ExploreServicesState {}

class ExploreServicesInitial extends ExploreServicesState {}

class ExploreServicesLoading extends ExploreServicesState {}

class ServicesLoaded extends ExploreServicesState {
  final List<ServiceModel> services;

  ServicesLoaded({required this.services});
}

class ServicesError extends ExploreServicesState {
  final String message;

  ServicesError({required this.message});
}