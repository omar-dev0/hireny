import '../../../../result.dart';
import '../../domain/models/event.dart';

abstract class CalenderDataSource{
  Future<Result<EventModel>?> addEvent(EventModel event , bool isSeeker) ;
  Future<Result<List<EventModel>>?> getUserEvents(bool isSeeker) ;

  }