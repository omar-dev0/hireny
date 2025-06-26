import 'package:hireny/features/auth/domain/modules/user/user.dart';
import 'package:hireny/features/seeker/domain/modules/course.dart';

import '../../features/seeker/domain/modules/job_post.dart';

abstract class AppSharedData {
  static User? user;
  static Map<String, List<String>> countryCityData = {};
  static List<String> nationalities = [];
  static List<Course> courses = [];
  static List<JobPost> jobPosts = []; // ← New field


  static List<String> careerLevels = [
    "Undergraduate",
    "Fresh Graduate / Entry-Level",
    "Junior",
    "Mid-Level",
    "Senior",
    "Lead / Tech Lead",
    "Software Architect / Engineering Manager",
  ];
  static List<String> employmentStatus = [
    "Full-Time",
    "Part-Time",
    "Freelancer",
    "Unemployed",
    "Student",
    "Intern",
    "Looking for Opportunities",
  ];
  static List<String> industries = [
    "Agriculture",
    "Automotive",
    "Banking & Finance",
    "Construction",
    "Consumer Goods",
    "Education",
    "Energy & Utilities",
    "Entertainment",
    "Environmental Services",
    "Fashion & Apparel",
    "Food & Beverage",
    "Government",
    "Healthcare",
    "Hospitality & Tourism",
    "Information Technology",
    "Insurance",
    "Legal Services",
    "Logistics & Transportation",
    "Manufacturing",
    "Media & Communications",
    "Mining",
    "Nonprofit",
    "Pharmaceuticals",
    "Real Estate",
    "Retail",
    "Software Development",
    "Telecommunications",
    "Textiles",
    "Waste Management",
    "Wholesale & Distribution"
  ];
static List<String> organizationSizes = [
  "Self-employed",
  "1-10",
  "11-50",
  "51-200",
  "201-500",
  "501-1,000",
  "1,001-5,000",
  "5,001-10,000",
  "10,001+"
];
static bool rememberMe = true;
}
