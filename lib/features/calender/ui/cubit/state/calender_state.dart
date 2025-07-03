import '../../../domain/models/event.dart';

abstract class CalenderState {}

class InitCalender extends CalenderState {}

class LoadingCalender extends CalenderState {}

class LoadingAddEvent extends CalenderState {}

class SuccessCalender extends CalenderState {
  List<EventModel> events;
  SuccessCalender(this.events);
}

class ErrorCalender extends CalenderState {}

class HideLoadingCalender extends CalenderState {}

class SuccessAddedEvent extends CalenderState {}
