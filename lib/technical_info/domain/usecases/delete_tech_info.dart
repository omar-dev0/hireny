import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/models/response/tech_info_respnonse.dart';
import 'package:injectable/injectable.dart';
import '../repo/tech_repo.dart';

@injectable
class DeleteTechInfo {
  final TechRepoInterface techRepo;

  DeleteTechInfo(this.techRepo);

  Future<Result<void>> call(String id,int deleteID) async {
    return await techRepo.deleteItem(id,deleteID);
  }

}
