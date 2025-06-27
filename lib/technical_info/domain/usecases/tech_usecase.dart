import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';
import '../repo/tech_repo.dart';

@injectable
class AddTechInfo {
  final TechRepoInterface techRepo;

  AddTechInfo(this.techRepo);

  Future<Result<void>> call(dynamic obj, int addID) {
    return techRepo.addTechInfo(obj, addID);
  }
}
