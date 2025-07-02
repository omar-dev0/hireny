abstract class ServiceOrgStates{}
class InitServiceOrg extends ServiceOrgStates{}
class LoadingServiceOrg extends ServiceOrgStates{}
class SuccessSetItems extends ServiceOrgStates{}

class SuccessServiceOrg extends ServiceOrgStates{}

class ErrorServiceOrg extends ServiceOrgStates{
  String? message;
  ErrorServiceOrg(this.message);
}
