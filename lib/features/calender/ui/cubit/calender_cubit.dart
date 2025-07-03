import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/calender/domain/models/event.dart';
import 'package:hireny/features/calender/ui/cubit/state/calender_state.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/calender_repo_contract.dart';

@injectable
class CalenderCubit extends Cubit<CalenderState> {
  final Map<DateTime, List<String>> events = {};
  CalenderRepoContract calenderRepoContract;
  @factoryMethod
  CalenderCubit(this.calenderRepoContract) : super(InitCalender());

  Future<void> getEvents() async {
    try {
      emit(LoadingCalender());
      var result = await calenderRepoContract.getUserEvents();
      switch (result) {
        case null:
          {
            emit(ErrorCalender());
          }
        case Success<List<EventModel>>():
          {
            AppSharedData.events = result.response ?? [];
            mapEventsByDate(AppSharedData.events);
            emit(SuccessCalender(AppSharedData.events));
          }
        case Error<List<EventModel>>():
          {
            emit(ErrorCalender());
          }
      }
    } catch (e) {
      emit(ErrorCalender());
    }
  }

  Future<void> addEvent(EventModel event) async {
    try {
      emit(LoadingAddEvent());
      var result = await calenderRepoContract.addEvent(event);
      switch (result) {
        case null:
          {
            emit(HideLoadingCalender());
            emit(ErrorCalender());
          }
        case Success<void>():
          {
            emit(HideLoadingCalender());
            AppSharedData.events.add(event);
            addSingleEventToMap(event, events);
            emit(SuccessAddedEvent());
          }
        case Error<void>():
          {
            emit(HideLoadingCalender());
            emit(ErrorCalender());
          }
      }
    } catch (e) {
      emit(HideLoadingCalender());
      emit(ErrorCalender());
    }
  }

  void mapEventsByDate(List<EventModel> eventList) {
    final Map<DateTime, List<String>> mappedEvents = {};

    for (var event in eventList) {
      final dateKey = DateTime(
        event.startDate!.year,
        event.startDate!.month,
        event.startDate!.day,
      );
      if (!mappedEvents.containsKey(dateKey)) {
        mappedEvents[dateKey] = [];
      }
      mappedEvents[dateKey]!.add(event.title ?? "");
    }

    events.addAll(mappedEvents);
  }

  void addSingleEventToMap(
    EventModel event,
    Map<DateTime, List<String>> eventsMap,
  ) {
    final dateKey = DateTime(
      event.startDate!.year,
      event.startDate!.month,
      event.startDate!.day,
    );

    if (!eventsMap.containsKey(dateKey)) {
      eventsMap[dateKey] = [];
    }

    eventsMap[dateKey]!.add(event.title ?? "");
  }
}
