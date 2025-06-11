import 'package:hive/hive.dart';
part 'link.g.dart';

@HiveType(typeId: 33)
class UserLink {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final String url;

  UserLink({required this.type, required this.url});

  factory UserLink.fromJson(Map<String, dynamic> json) => UserLink(
    type: json['type'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
    };
  }
}