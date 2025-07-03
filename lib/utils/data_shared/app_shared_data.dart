import 'package:hireny/features/auth/domain/modules/user/user.dart';
import 'package:hireny/features/organization/domain/modules/seeker.dart';
import 'package:hireny/features/organization/domain/modules/service.dart';
import 'package:hireny/features/seeker/domain/modules/course.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/features/show_courses/data/models/seeker_courses_registered.dart';

import '../../features/organization/domain/modules/organization.dart';
import '../../features/seeker/domain/modules/job_post.dart';
import '../../features/seeker/domain/modules/org_post.dart';

abstract class AppSharedData {
  static User? user;
  static Map<String, List<String>> countryCityData = {};
  static List<String> nationalities = [];
  static List<Course> courses = [];
  static List<String> countries = [];
  static List<String> jobs = [];
  static List<ServiceResponse> servicesOrg = [];
  static List<JobPost> jobPosts = [];
  static List<OrgPost> orgPosts = [];
  static List<OrgPostOrg> orgs = [];
  static List<SeekerModel> seekers = [];
  static List<ServiceModel> services = [];
  static List<String> jobTitle = [
    "Internship",
    "Full-Time",
    "Part-Time",
    "Temporary",
    "Freelance",
    "Contract",
    "Volunteer"
  ];
  static List<RegisteredCourses> registeredCourses = [];

  static Map<String,List<dynamic>>? techInfo ;
  static bool calling = false ;
  static List<String> careerLevels = [
    "Entry Level",
    "Early Career",
    "Mid Career",
    "Experienced",
    "Late Career",
  ];
  static List<String> employmentStatus = [
    "Student",
    "Fresh Graduate",
    "Intern",
    "Trainee",
    "Employee",
    "Unemployed",
    "Contractor",
    "Freelancer",
    "Part-Time Employee",
    "Temporary Employee",
    "Retired",
    "Volunteer",
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
    "Wholesale & Distribution",
  ];
  static List<String> organizationSizes = [
    "Self-Employed",
    "1-10 Employees",
    "11-50 Employees",
    "51-100 Employees",
    "101-200 Employees",
    "201-500 Employees",
    "501-1000 Employees",
    "1001-5000 Employees",
    "5001-10000 Employees",
    "10001+ Employees",
    "Other",
  ];
  static bool rememberMe = true;

  static List<String> skills = []; //===============> 38592

  static List<String> jobLocationTypes = ["On-Site", "Remote", "Hybrid"];

  static List<String> categories = [];

  static List<String> lang =  [];

  static List<String> educationLevels = [
    "No Formal Education",
    "Primary School",
    "Middle School / Junior High School",
    "High School Incomplete",
    "High School Diploma / Secondary School",
    "Vocational Training / Technical Certificate",
    "Associate'S Degree",
    "Diploma",
    "Bachelor'S Degree",
    "Postgraduate Diploma / Higher Diploma",
    "Master'S Degree",
    "Professional Degree (Md, Jd, Pharmd, Etc.)",
    "Doctorate / Phd",
    "Post-Doctoral Studies",
    "Some College, No Degree",
    "Currently Studying",
    "Other / Not Specified",
  ];

  static List<String> coursesLen = [
    "Less Than 1 Hour",
    "1–5 Hours",
    "6–10 Hours",
    "11–20 Hours",
    "21–30 Hours",
    "31–50 Hours",
    "51–75 Hours",
    "76–100 Hours",
    "101–150 Hours",
    "151–200 Hours",
    "More Than 200 Hours",
    "Self-Paced",
    "Other",
  ];

  static bool initNotfication = false;
}
