import 'package:hireny/features/auth/data/api/api_manger.dart';
import 'package:hireny/features/auth/data/data_source/auth_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class DataSourcAuthImp implements AuthDataSource {
  ApiManger apiManger;
  @factoryMethod
  DataSourcAuthImp(this.apiManger);
  @override
  Future<void> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> registration() {
    // TODO: implement registration
    throw UnimplementedError();
  }
}


