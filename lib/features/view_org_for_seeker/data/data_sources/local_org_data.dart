import 'package:injectable/injectable.dart';

import '../../domain/entities/org_entity.dart';
import '../models/org_response.dart';
import 'org_data_interface.dart';

@LazySingleton(as: OrgDataInterface)
class LocalOrgData implements OrgDataInterface {
  final List<OrgEntity> fixedOrgsData = [
    OrgEntity(orgID: 1, orgPresenterName: 'Andrew Walter', orgEmail: 'hr@eliteworkforce.com', joinDate: '09-12-2010', status: OrgStatus.pending),
    OrgEntity(orgID: 2, orgPresenterName: 'Lina Robert', orgEmail: 'support@globalcareers.com', joinDate: '22-02-2013',status: OrgStatus.pending),
    OrgEntity(orgID: 3, orgPresenterName: 'Sophia James', orgEmail: 'support@globalcareers.com', joinDate: '22-02-2013',status: OrgStatus.approved),
    OrgEntity(orgID: 4, orgPresenterName: 'Adam James', orgEmail: 'support@globalcareers.com', joinDate: '22-02-2013',status: OrgStatus.pending),


  ];
  late List<OrgEntity> orgPendingData;
  LocalOrgData() {
    orgPendingData = fixedOrgsData.where((org) => org.status == OrgStatus.pending).toList();
  }

  @override
  Future<List<OrgResponse>> getOrg()async{
    print("pending");
    for (var org in orgPendingData) {
      print('-> ID: ${org.orgID}, Presenter: ${org.orgPresenterName}, Email: ${org.orgEmail}, Date: ${org.joinDate}');
    }
    return orgPendingData.map((org) => OrgResponse(
      orgID: org.orgID,
      orgPresenterName: org.orgPresenterName,
      orgEmail: org.orgEmail,
      joinDate: org.joinDate,
      status: org.status,
    )).toList();
  }

  @override
  Future<OrgResponse> verifyOrg(OrgEntity orgData, bool orgState) async {

      final index = fixedOrgsData.indexWhere((org) => org.orgID == orgData.orgID);
      print(index);
      if (index == -1) {
        throw Exception('Organization not found');
      }

      fixedOrgsData[index].status = orgState ? OrgStatus.approved : OrgStatus.rejected;

      orgPendingData = fixedOrgsData.where((org) => org.status == OrgStatus.pending).toList();
      print("changing");
      for (var org in orgPendingData) {
        print('-> ID: ${org.orgID}, Presenter: ${org.orgPresenterName}, Email: ${org.orgEmail}, Date: ${org.joinDate}');
      }
      return OrgResponse(
        orgID: fixedOrgsData[index].orgID,
        orgPresenterName: fixedOrgsData[index].orgPresenterName,
        orgEmail: fixedOrgsData[index].orgEmail,
        joinDate: fixedOrgsData[index].joinDate,
        status: fixedOrgsData[index].status,
      );    }

}
