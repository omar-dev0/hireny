sealed class RegState {}

class InitReg extends RegState {}

class LoadingReg extends RegState {}

class RegSuccess extends RegState {
  String? message;
  RegSuccess({this.message});
}

class RegError extends RegState {
  String? message;
  RegError({this.message});
}

class HideRegLoading extends RegState {}

class ValidateDate extends RegState {}

class ValidateGender extends RegState {}

class ValidateNationality extends RegState {}


class ValidateCountry extends RegState {}

class ValidateCity extends RegState {}

class ValidateCareerLevel extends RegState {}

class ValidateEmploymentStatus extends RegState {}

class ValidateFile extends RegState {}

class ValidateIndestry extends RegState {}

class ValidateOrgSize extends RegState {}


