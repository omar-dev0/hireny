import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';
import '../repo/tech_repo.dart';

@injectable
class UpdateTechInfo {
  final TechRepoInterface techRepo;

  UpdateTechInfo(this.techRepo);

  Future<Result<void>> call(String id,dynamic data,int updateID)  {
    return  techRepo.updateTechInfo(id,data,updateID);
  }

}
