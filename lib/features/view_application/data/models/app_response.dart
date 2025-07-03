import '../../domain/entities/application_entity.dart';

class AppResponse extends AppEntity {
  AppResponse({
    required super.appID,
    required super.applicationType,
    required super.companyName,
    required super.appliedDate,
    required super.deadlineDate,
    required super.status,
  });
}
