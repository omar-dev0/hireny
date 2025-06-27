import 'package:hireny/result.dart';
import '../../data/models/response/education_model.dart';
import '../../data/models/response/tech_info_respnonse.dart';

abstract class TechRepoInterface{

  Future<Result<void>>addEdu(Educations model);
  Future<Result<TechInfoResponse>> getTechInfo(String token);
  Future<Result<void>> deleteItem(String id,int deleteID);

  }