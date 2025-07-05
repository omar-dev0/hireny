class ReviewModel {
   num? id;
   String? message;
   DateTime? createdAt;
   DateTime? updatedAt;
   int? organization;
   int? reviewer;
   String? reviewerName;
   String? reviewerPhoto;
   UserChatData? userChatData;

  ReviewModel({
    this.id,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.organization,
    this.reviewer,
    this.reviewerName,
    this.reviewerPhoto,
    this.userChatData,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      organization: json['organization'],
      reviewer: json['reviewer'],
      reviewerName: json['reviewerName'],
      reviewerPhoto: json['reviewerPhoto'],
      userChatData: UserChatData.fromJson(json['UserChatData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'organization': organization,
      'reviewer': reviewer,
      'reviewerName': reviewerName,
      'reviewerPhoto': reviewerPhoto,
      'UserChatData': userChatData?.toJson(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class UserChatData {
  final int? seekerId;
  final String? seekerName;
  final String? seekerPhoto;
  final int? orgAdminId;
  final String? orgName;
  final String? orgPhoto;
  final String? role;
  final int? orgId;

  UserChatData({
    this.seekerId,
    this.seekerName,
    this.seekerPhoto,
    this.orgAdminId,
    this.orgName,
    this.orgPhoto,
    required this.role,
    this.orgId,
  });

  factory UserChatData.fromJson(Map<String, dynamic> json) {
    return UserChatData(
      seekerId: json['seekerId'],
      seekerName: json['seekerName'],
      seekerPhoto: json['seekerPhoto'],
      orgAdminId: json['orgAdminId'],
      orgName: json['orgName'],
      orgPhoto: json['orgPhoto'],
      role: json['role'],
      orgId: json['orgId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seekerId': seekerId,
      'seekerName': seekerName,
      'seekerPhoto': seekerPhoto,
      'orgAdminId': orgAdminId,
      'orgName': orgName,
      'orgPhoto': orgPhoto,
      'role': role,
      'orgId': orgId,
    };
  }
}
