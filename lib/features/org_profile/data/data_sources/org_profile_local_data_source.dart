import 'package:hireny/features/org_profile/data/data_sources/org_profile_data_interface.dart';
import 'package:hireny/features/org_profile/domain/entities/org_post_entity.dart';
import 'package:hireny/features/org_profile/domain/entities/org_review_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/org_profile_entity.dart';

@LazySingleton(as: OrgProfileDataInterface)
class OrgProfileLocalDataSource implements OrgProfileDataInterface {
  final List<OrgProfileEntity> fixedData = [
    OrgProfileEntity(
      orgID: 1,
      description:
          'We are a leading tech company building impactful solutions.',
      ceoName: 'Jane Doe',
      foundedDate: '2010',
      employeesNum: 250000,
      industry: 'Information Technology',
      location: 'Smart Village',
      postCard: [
        OrgPostCardEntity(
          postID: 1,
          postTitle: "Flutter Developer",
          publishedTime: "24 min",
          jobType: "Part-time",
          jobTime: JobTime.part,
          salary: "15000",
          location: "Cairo",
        ),
        OrgPostCardEntity(
          postID: 2,
          postTitle: "Backend Developer",
          publishedTime: "2 days",
          jobType: "Full-time",
          jobTime: JobTime.full,
          salary: "20000",
          location: "Alexandria",
        ),
      ],
      reviewCard: [
        OrgReviewEntity(
          reviewID: 1,
          owner: "Adam",
          publishedTime: "1 year ago",
          content: "Great company culture and leadership.",
        ),
        OrgReviewEntity(
          reviewID: 2,
          owner: "Sarah",
          publishedTime: "3 months ago",
          content: "Flexible hours and exciting projects.",
        ),
      ],
    ),
    OrgProfileEntity(
      orgID: 2,
      description: 'Creative agency specializing in digital branding.',
      ceoName: 'John Smith',
      foundedDate: '2015',
      employeesNum: 120,
      industry: 'Marketing & Design',
      location: 'Nasr City',
      postCard: [
        OrgPostCardEntity(
          postID: 3,
          postTitle: "Graphic Designer",
          publishedTime: "1 week",
          jobType: "Part-time",
          jobTime: JobTime.part,
          salary: "8000",
          location: "Cairo",
        ),
      ],
      reviewCard: [
        OrgReviewEntity(
          reviewID: 3,
          owner: "Lina",
          publishedTime: "2 months ago",
          content: "Collaborative and inspiring team.",
        ),
      ],
    ),
    OrgProfileEntity(
      orgID: 3,
      description: 'Startup focused on AI-driven healthcare solutions.',
      ceoName: 'Dr. Amal Hassan',
      foundedDate: '2018',
      employeesNum: 75,
      industry: 'HealthTech',
      location: 'New Cairo',
      postCard: [
        OrgPostCardEntity(
          postID: 4,
          postTitle: "AI Researcher",
          publishedTime: "3 days",
          jobType: "Full-time",
          jobTime: JobTime.full,
          salary: "25000",
          location: "Cairo",
        ),
        OrgPostCardEntity(
          postID: 5,
          postTitle: "Data Scientist Intern",
          publishedTime: "1 day",
          jobType: "Part-time",
          jobTime: JobTime.part,
          salary: "5000",
          location: "Remote",
        ),
      ],
      reviewCard: [
        OrgReviewEntity(
          reviewID: 4,
          owner: "Mina",
          publishedTime: "5 days ago",
          content: "Working on real problems with real impact!",
        ),
      ],
    ),
  ];
  late List<OrgProfileEntity> profileData;
  OrgProfileLocalDataSource() {
    profileData = List.from(fixedData);
  }

  @override
  Future<void> addReview(String reviewContent) async {
    var len = profileData[1].reviewCard.length;
    profileData[1].reviewCard.add(
      new OrgReviewEntity(
        reviewID: len + 1,
        owner: "user",
        publishedTime: "just not",
        content: reviewContent,
      ),
    );
    print(
      "Review added! Current reviews list:${profileData[1].reviewCard.length}",
    );
    for (var r in profileData[1].reviewCard) {
      print("- ${r.owner}: ${r.content}");
    }
  }

  @override
  List<OrgReviewEntity> getReviews() {
    var orgID = 2;
    var profile = profileData.firstWhere(
      (profile) => profile.orgID == orgID,
      orElse: () => throw Exception('Profile with ID $orgID not found'),
    );
    print("get review -----?:${profileData[1].reviewCard.length}");

    for (var review in profile.reviewCard) {
      print("Review ID: ${review.reviewID}");
      print("Owner: ${review.owner}");
      print("Published Time: ${review.publishedTime}");
      print("Content: ${review.content}");
      print("---------------");
    }
    return profile.reviewCard;
  }

  @override
  OrgPostCardEntity getPost(int postID) {
    for (var profile in profileData) {
      try {
        return profile.postCard.firstWhere((post) => post.postID == postID);
      } catch (_) {}
    }
    throw Exception("Post with ID $postID not found");
  }

  @override
  List<OrgPostCardEntity> getPosts() {
    return profileData[0].postCard;
  }

  @override
  Future<OrgProfileEntity> getProfile(int orgID) async {
    return profileData.firstWhere((profile) => profile.orgID == orgID);
  }
}
