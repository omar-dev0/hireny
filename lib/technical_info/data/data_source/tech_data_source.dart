import 'package:hireny/result.dart';
import '../models/response/education_model.dart';
import '../models/response/tech_info_respnonse.dart';

abstract class TechDataSourceInterface{
  Future<Result<void>>addEdu(Educations model);
  Future<Result<TechInfoResponse>> getTechInfo(String token);
  Future<Result<void>> deleteItem(String id,int deleteID);


}