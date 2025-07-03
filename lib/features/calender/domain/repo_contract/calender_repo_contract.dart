import '../../../../result.dart';
import '../models/event.dart';

abstract class CalenderRepoContract {
  Future<Result<void>?> addEvent(EventModel event);
  Future<Result<List<EventModel>>?> getUserEvents();
}
