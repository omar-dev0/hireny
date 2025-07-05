import 'package:hireny/features/view_application/data/api/api_manger.dart';
import 'package:injectable/injectable.dart';

import '../../../../result.dart';
import '../../domain/model/user_application.dart';
import '../data_source/application_data_scource.dart';

@Injectable(as: ApplicationDataSource)
class ApplicationDataSourceImp extends ApplicationDataSource {
  final ApplicationApi applicationApi;

  @factoryMethod
  ApplicationDataSourceImp(this.applicationApi);

  @override
  Future<Result<List<SeekerApplication>>?> getUserApplication() {
    return applicationApi.getUserApplication();
  }


}