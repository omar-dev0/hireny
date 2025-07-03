class ChatBootModel {
  String? message;
  ChatBootModel({this.message});

  factory ChatBootModel.fromJson(Map<String, dynamic> json) =>
      ChatBootModel(message: json['message']);

  Map<String, dynamic> toJson() => {"message": message};
}
