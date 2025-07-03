import 'package:injectable/injectable.dart';

import '../entities/org_entity.dart';
import '../repositories/org_repo.dart';

@injectable
class ShowOrg {
  OrgRepo orgRepo;

  ShowOrg({required this.orgRepo});
  Future<List<OrgEntity>> call() async {
    return await orgRepo.getOrg();
  }
}
