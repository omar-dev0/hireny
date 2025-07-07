abstract class AIState {}

class AIInitState extends AIState {}

class LoadingAiState extends AIState {}

class SuccessAiState extends AIState {}

class ErrorAiState extends AIState {
  String? error;
  ErrorAiState({this.error});
}

class HideAiState extends AIState {}

