import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/models/response/tech_info_respnonse.dart';
import 'package:injectable/injectable.dart';
import '../repo/tech_repo.dart';

@injectable
class GetTechInfo {
  final TechRepoInterface techRepo;

  GetTechInfo(this.techRepo);

  Future<Result<void>> call(String id) async {
    return await techRepo.getTechInfo(id);
  }
}
