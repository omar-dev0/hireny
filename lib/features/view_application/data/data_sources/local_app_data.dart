import 'package:hireny/features/view_application/data/data_sources/app_data_interface.dart';
import 'package:hireny/features/view_application/data/models/app_response.dart';
import 'package:hireny/features/view_application/domain/entities/application_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppDataInterface)

class LocalAppData implements AppDataInterface{
  final List<AppEntity> fixedAppData = [
    AppEntity(appID: 1, applicationType: "Flutter", companyName: "Google", appliedDate: "09-12-2022", deadlineDate: "19-12-2022", status: AppStatus.completed),
    AppEntity(appID: 2, applicationType: "Node.js", companyName: "Google", appliedDate: "09-12-2022", deadlineDate: "19-12-2022", status: AppStatus.approved),
    AppEntity(appID: 3, applicationType: "Flutter", companyName: "Google", appliedDate: "09-12-2022", deadlineDate: "19-12-2022", status: AppStatus.pending),
    AppEntity(appID: 4, applicationType: "Flutter", companyName: "Google", appliedDate: "09-12-2022", deadlineDate: "19-12-2022", status: AppStatus.rejected),

  ];

  late List<AppEntity> AppData;

  LocalAppData() {
    AppData = fixedAppData.toList();
  }

  @override
  Future<void> deleteApplication(AppEntity application) async{
    final index = AppData.indexWhere((app) => app.appID == application.appID);
    if (index != -1) {
      AppData.removeAt(index);
    } else {
      throw Exception('Application not found');
    }
  }

  @override
  Future<List<AppResponse>> showApplications() async {
    return AppData.map((app) => AppResponse(
        appID: app.appID, applicationType: app.applicationType,
        companyName: app.companyName, appliedDate: app.appliedDate,
        deadlineDate: app.deadlineDate, status: app.status)).toList();
  }

}