import 'dart:convert';

import 'package:hive/hive.dart';
part 'link.g.dart';

@HiveType(typeId: 33)
class UserLink {
  @HiveField(0)
  final String? type;
  @HiveField(1)
  final String? url;

  UserLink({ this.type,  this.url});

  factory UserLink.fromJson(Map<String, dynamic> json) =>
      UserLink(type: json['type'], url: json['url']);

  Map<String, dynamic> toJson() {
    return {'type': type, 'url': url};
  }
  /// Decode JSON string into List<UserLink>
  static List<UserLink> decode(String linksJson) {
    final parsed = jsonDecode(linksJson).cast<Map<String, dynamic>>();
    return parsed.map<UserLink>((json) => UserLink.fromJson(json)).toList();
  }

  /// Encode List<UserLink> into JSON string
  static String encode(List<UserLink>? links) {
    if (links == null || links.isEmpty) return '[]';
    return jsonEncode(links.map((link) => link.toJson()).toList());
  }
}
