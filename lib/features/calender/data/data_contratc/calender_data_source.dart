import '../../../../result.dart';
import '../../domain/models/event.dart';

abstract class CalenderDataSource{
  Future<Result<void>?> addEvent(EventModel event) ;
  Future<Result<List<EventModel>>?> getUserEvents() ;

  }