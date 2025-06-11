sealed class Result<T> {}

class Success<T> extends Result<T> {
  T? response;
  Success({this.response});
}

class Error<T> extends Result<T> {
  String? error;
  Error({this.error});
}
