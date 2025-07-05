import 'package:hireny/features/view_application/data/data_source/application_data_scource.dart';
import 'package:hireny/features/view_application/domain/model/user_application.dart';
import 'package:hireny/features/view_application/domain/repo_contract/application_repo_contratc.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ApplicationRepo)
class ApplicationRepoImp extends ApplicationRepo {
  ApplicationDataSource applicationDataSource;
  @factoryMethod
  ApplicationRepoImp(this.applicationDataSource);

  @override
  Future<Result<List<SeekerApplication>>?> getUserApplication() {
    return applicationDataSource.getUserApplication();
  }
}
