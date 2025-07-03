import 'package:hireny/technical_info/data/data_source/tech_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../result.dart';
import '../../domain/repo/tech_repo.dart';
import '../models/response/education_model.dart';
import '../models/response/tech_info_respnonse.dart';

@LazySingleton(as: TechRepoInterface)
class TechRepoImpl implements TechRepoInterface {
  final TechDataSourceInterface dataSource;

  TechRepoImpl(this.dataSource);

  @override
  Future<Result<void>> addTechInfo(dynamic obj, int addID) {
    return dataSource.addTechInfo(obj, addID);
  }

  @override
  Future<Result<TechInfoResponse>> getTechInfo(String token) {
    return dataSource.getTechInfo(token);
  }

  @override
  Future<Result<void>> deleteItem(String id, int deleteID) {
    return dataSource.deleteItem(id, deleteID);
  }

  @override
  Future<Result<void>> updateTechInfo(String id,dynamic data ,int updateID) {
    return dataSource.updateTechInfo(id,data, updateID);

  }


}
