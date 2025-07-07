import 'package:hireny/features/calender/data/api/api_manger.dart';
import 'package:hireny/features/calender/domain/models/event.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../data_contratc/calender_data_source.dart';

@Injectable(as: CalenderDataSource)
class CalenderDataSourceImp extends CalenderDataSource {
  CalenderApi calenderApi;
  @factoryMethod
  CalenderDataSourceImp(this.calenderApi);

  @override
  Future<Result<EventModel>?> addEvent(EventModel event , bool isSeeker) {
    return calenderApi.addEvent(event , isSeeker);
  }

  @override
  Future<Result<List<EventModel>>?> getUserEvents(bool isSeeker) {
    return calenderApi.getUserEvents(isSeeker);
  }
}
