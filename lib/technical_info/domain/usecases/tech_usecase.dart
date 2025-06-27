
import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/models/response/tech_info_respnonse.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/response/education_model.dart';
import '../repo/tech_repo.dart';

@injectable
class AddEdu {
  final TechRepoInterface techRepo;

  AddEdu(this.techRepo);

  Future<Result<void>> call(Educations model) async {
    return await techRepo.addEdu(model);
  }

}
