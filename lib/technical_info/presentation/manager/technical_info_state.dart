part of 'technical_info_cubit.dart';

@immutable
sealed class TechnicalInfoState {}

final class TechnicalInfoInitial extends TechnicalInfoState {}
final class TechnicalInfoLoading extends TechnicalInfoState {}
final class TechnicalInfoSuccess extends TechnicalInfoState {}
final class TechnicalInfoSuccessUpdated extends TechnicalInfoState {}
final class TechnicalInfoSuccessDeleted extends TechnicalInfoState {}

final class TechnicalInfoFailure extends TechnicalInfoState {
  String? message;
  TechnicalInfoFailure(this.message);
}
