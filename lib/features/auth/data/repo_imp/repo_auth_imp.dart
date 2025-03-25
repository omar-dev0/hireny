import 'package:hireny/features/auth/data/data_source/auth_data_source.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RepoAuth)
class RepoAuthImp extends RepoAuth{
  AuthDataSource dataSource;
  @factoryMethod
  RepoAuthImp(this.dataSource);
  @override
  Future<void> login() {
    return dataSource.login();
  }

  @override
  Future<void> registration() {
    return dataSource.registration();
  }

}