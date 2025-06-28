import 'package:hireny/result.dart';
import '../models/response/tech_info_respnonse.dart';

abstract class TechDataSourceInterface{
  Future<Result<TechInfoResponse>> getTechInfo(String token);
  Future<Result<void>> deleteItem(String id,int deleteID);
  Future<Result<void>> addTechInfo(dynamic obj , int addID);
  Future<Result<void>> updateTechInfo(String id,dynamic data,int updateID);
}