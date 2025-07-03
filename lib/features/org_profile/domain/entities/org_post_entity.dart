enum JobTime { full, part }

class OrgPostCardEntity {
  int postID;
  String postTitle;
  String publishedTime;
  String jobType;
  JobTime jobTime;
  String salary;
  String location;

  OrgPostCardEntity({
    required this.postID,
    required this.postTitle,
    required this.publishedTime,
    required this.jobType,
    required this.jobTime,
    required this.salary,
    required this.location,
  });
}
