import 'package:hireny/features/view_application/data/data_sources/app_data_interface.dart';
import 'package:hireny/features/view_application/domain/entities/application_entity.dart';
import 'package:hireny/features/view_application/domain/repositories/app_repo_interface.dart';
import 'package:injectable/injectable.dart';


@Injectable(as:AppRepoInterface)

class AppRepoImpl implements AppRepoInterface{
  final AppDataInterface data;
  AppRepoImpl(this.data);

  @override
  Future<void> deleteApplication(AppEntity appData) async{
    return await data.deleteApplication(appData);
  }

  @override
  Future<List<AppEntity>> showApplications()async {
    return await data.showApplications();

  }

}