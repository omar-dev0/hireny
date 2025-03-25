String? emailValidation(String? val) {
  if (val!.isEmpty) {
    return 'this field is required';
  }
  final bool emailValid = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(val);
  if (!emailValid) {
    return 'invalide email please enter correct email';
  }
  return null;
}

String? passwordValidator(String? val) {
  if (val!.isEmpty) {
    return 'this field is required';
  }
  if (val!.length < 8) {
    return 'password length must be 8 or more';
  }
  return null;
}

