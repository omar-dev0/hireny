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
  Future<Result<void>?> addEvent(EventModel event) {
    return calenderApi.addEvent(event);
  }

  @override
  Future<Result<List<EventModel>>?> getUserEvents() {
    return calenderApi.getUserEvents();
  }
}
