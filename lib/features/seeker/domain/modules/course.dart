class Course {
  final int id;
  final String title;
  final String price;
  final String instructorName;
  final String logoImage;
  final String requestsCount;

  Course({
    required this.id,
    required this.title,
    required this.price,
    required this.instructorName,
    required this.logoImage,
    required this.requestsCount,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      price: json['price'] ?? 'Free',
      instructorName: 'Instructor name: ${json['instructor_name']}',
      logoImage: json['logo_image'] ?? '',
      requestsCount: '${json['requests_count']}+ requested',
    );
  }
}