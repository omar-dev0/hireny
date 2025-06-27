import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/api/api_manager.dart';
import 'package:hireny/technical_info/data/data_source/tech_data_source.dart';
import 'package:hireny/technical_info/data/models/response/tech_info_respnonse.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: TechDataSourceInterface)
class TechDataSource implements TechDataSourceInterface {
  final TechApiManager techApiManager;

  TechDataSource(this.techApiManager);



  @override
  Future<Result<void>> addTechInfo(dynamic obj , int addID) {
    return techApiManager.addTechInfo(obj,addID);
  }

  @override
  Future<Result<TechInfoResponse>> getTechInfo(String token) {
    return techApiManager.getTechInfo(token);
  }

  @override
  Future<Result<void>> deleteItem(String id,int deleteID){
    return techApiManager.deleteTechInfo(id, deleteID);
  }
}

