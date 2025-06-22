import 'package:hireny/features/view_org/domain/entities/org_entity.dart';
import 'package:hireny/features/view_org/domain/repositories/org_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class ShowOrg{
  OrgRepo orgRepo;

  ShowOrg({required this.orgRepo});
  Future<List<OrgEntity>>call() async {
    return await orgRepo.getOrg();
  }
}