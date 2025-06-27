import 'package:hireny/result.dart';
import '../../data/models/response/education_model.dart';
import '../../data/models/response/tech_info_respnonse.dart';

abstract class TechRepoInterface{

  Future<Result<TechInfoResponse>> getTechInfo(String token);
  Future<Result<void>> deleteItem(String id,int deleteID);
  Future<Result<void>> addTechInfo(dynamic obj , int addID);
  }