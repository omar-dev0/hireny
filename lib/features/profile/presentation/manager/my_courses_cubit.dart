import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_courses_state.dart';

@injectable
class MyCoursesCubit extends Cubit<MyCoursesState> {
  MyCoursesCubit() : super(MyCoursesInitial());
  final List<Map<String, dynamic>> courseList = [
    {
      'name': 'Complete Data Science Bootcamp 2025',
      'sections': 25,
      'hours': 40,
      'level': 'All Levels',
    },
    {
      'name': 'Flutter & Dart - The Complete Guide',
      'sections': 30,
      'hours': 50,
      'level': 'Beginner',
    },
    {
      'name': 'Machine Learning A-Z™: Hands-On Python & R',
      'sections': 35,
      'hours': 44,
      'level': 'Intermediate',
    },
    {
      'name': 'Web Development Bootcamp 2025',
      'sections': 40,
      'hours': 60,
      'level': 'All Levels',
    },
    {
      'name': 'React Native + Hooks Masterclass',
      'sections': 20,
      'hours': 25,
      'level': 'Intermediate',
    },
    {
      'name': 'SQL for Data Analytics and BI',
      'sections': 15,
      'hours': 12,
      'level': 'Beginner',
    },
    {
      'name': 'Python for Everybody',
      'sections': 12,
      'hours': 15,
      'level': 'Beginner',
    },
    {
      'name': 'Advanced AI & GenAI for Developers',
      'sections': 18,
      'hours': 28,
      'level': 'Advanced',
    },
    {
      'name': 'Java Programming Masterclass',
      'sections': 32,
      'hours': 42,
      'level': 'All Levels',
    },
    {
      'name': 'Cybersecurity Fundamentals',
      'sections': 16,
      'hours': 20,
      'level': 'Intermediate',
    },
  ];

  List<Map<String, dynamic>> getMyCourses()
  {
    emit(MyCoursesSuccess());
    return courseList;
  }

  Map<String,dynamic> getCourse({required String courseName})
  {
    emit(MyCoursesSuccess());
    final course = courseList.firstWhere(
          (course) => course['name'] == courseName,
    );
    return course;
  }

}
