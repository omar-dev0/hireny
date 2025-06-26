abstract class SalaryState {}

class LoadingSalary extends SalaryState {}

class SuccessSalary extends SalaryState {
  num? salary;
  SuccessSalary({this.salary});
}

class FailSalary extends SalaryState {
  String? error;
  FailSalary({this.error});
}

class InitSalary extends SalaryState {}

class HideDialogSalary extends SalaryState {}
