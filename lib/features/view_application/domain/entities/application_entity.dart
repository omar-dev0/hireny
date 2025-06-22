enum AppStatus {
  pending,
  approved,
  rejected,
  completed,
}
class AppEntity {
  int appID;
  String applicationType;
  String companyName;
  String appliedDate;
  String deadlineDate;
  AppStatus status;

  AppEntity({
    required this.appID,
    required this.applicationType,
    required this.companyName,
    required this.appliedDate,
    required this.deadlineDate,
    required this.status,}
  );
}
