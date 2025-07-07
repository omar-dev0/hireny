import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';
import '../repo/tech_repo.dart';

@injectable
class DeleteTechInfo {
  final TechRepoInterface techRepo;

  DeleteTechInfo(this.techRepo);

  Future<Result<void>> call(String id,int deleteID)  {
    return  techRepo.deleteItem(id,deleteID);
  }

}
