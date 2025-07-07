import 'package:hireny/features/calender/data/data_contratc/calender_data_source.dart';
import 'package:hireny/features/calender/domain/models/event.dart';
import 'package:hireny/features/calender/domain/repo_contract/calender_repo_contract.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CalenderRepoContract)
class CalenderRepoImp extends CalenderRepoContract {
  CalenderDataSource calenderDataSource;
  @factoryMethod
  CalenderRepoImp(this.calenderDataSource);

  @override
  Future<Result<EventModel>?> addEvent(EventModel event) {
    return calenderDataSource.addEvent(event);
  }

  @override
  Future<Result<List<EventModel>>?> getUserEvents() {
    return calenderDataSource.getUserEvents();
  }
}
