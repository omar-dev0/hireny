import 'package:flutter/foundation.dart';

import 'lesson.dart';

class Course {
  final int id;
  final String title;
  final String price;
  final String instructorName;
  final String createdAt;
  final String updatedAt;
  final List<String> category;
  final String description;
  final double totalDuration; // in seconds or minutes — define based on API
  final List<Lesson> lessons;
  final String currency;

  Course({
    required this.id,
    required this.title,
    required this.price,
    required this.instructorName,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.description,
    required this.totalDuration,
    required this.lessons,
    required this.currency,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    // Handle category list
    List<String> categories = [];
    if (json['category'] is List) {
      categories =
          (json['category'] as List)
              .map((item) => item.toString().toLowerCase())
              .toList();
    }

    // Handle lessons list
    List<Lesson> lessons = [];
    if (json['lessons'] is List) {
      lessons =
          (json['lessons'] as List)
              .map((item) => Lesson.fromJson(item))
              .toList();
    }

    return Course(
      id: json['id'],
      title: json['title'],
      price: json['priceAmount'] ?? 'Free',
      instructorName: json['instructor'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      category: categories,
      description: json['description'] ?? '',
      totalDuration: json['total_duration']?.toDouble() ?? 0.0,
      lessons: lessons,
      currency: json['currency'] ?? '',
    );
  }
}
