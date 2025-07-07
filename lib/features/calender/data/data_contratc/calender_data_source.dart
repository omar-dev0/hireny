import '../../../../result.dart';
import '../../domain/models/event.dart';

abstract class CalenderDataSource{
  Future<Result<EventModel>?> addEvent(EventModel event) ;
  Future<Result<List<EventModel>>?> getUserEvents() ;

  }