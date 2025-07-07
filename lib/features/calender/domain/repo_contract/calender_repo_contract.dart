import '../../../../result.dart';
import '../models/event.dart';

abstract class CalenderRepoContract {
  Future<Result<EventModel>?> addEvent(EventModel event);
  Future<Result<List<EventModel>>?> getUserEvents();
}
