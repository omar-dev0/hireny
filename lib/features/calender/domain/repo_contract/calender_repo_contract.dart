import '../../../../result.dart';
import '../models/event.dart';

abstract class CalenderRepoContract {
  Future<Result<EventModel>?> addEvent(EventModel event , bool isSeeker);
  Future<Result<List<EventModel>>?> getUserEvents(bool isSeeker);
}
