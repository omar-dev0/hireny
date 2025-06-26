class Course {
  final int id;
  final String title;
  final String price;
  final String instructorName;
  final String createdAt;
  final List<String> category;
  final String description; // ← New Field


  Course({
    required this.id,
    required this.title,
    required this.price,
    required this.instructorName,
    required this.createdAt,
    required this.category,
    required this.description, // ← Add here

  });

  factory Course.fromJson(Map<String, dynamic> json) {
    // Handle category list
    List<String> categories = [];
    if (json['category'] is List) {
      categories = (json['category'] as List).map((item) => item.toString().toLowerCase()).toList();
    }

    return Course(
      id: json['id'],
      title: json['title'],
      price: json['priceAmount'] ?? '0.0',
      instructorName: json['instructor'],
      createdAt: json['created_at'],
      category: categories,
      description: json['description'] ?? '', // ← Add this line

    );
  }
}