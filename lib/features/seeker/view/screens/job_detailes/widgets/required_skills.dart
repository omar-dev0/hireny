import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/extensions/font_size.dart';

class RequiredSkills extends StatelessWidget {
  final List<String> skills;

  const RequiredSkills({super.key, required this.skills});
  final List<String> skillsList = const [
    'Flutter',
    'Firebase',
    'REST API',
    'Git',
    'UI/UX',
    'Dart',
    'SQL',
    'Clean Architecture',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: skills.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 3.2,
              ),
              itemBuilder:
                  (context, index) => FadeInUp(
                    delay: Duration(milliseconds: index * 100),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.purple.shade700],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.subPrimary2,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              skills[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.cSp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
