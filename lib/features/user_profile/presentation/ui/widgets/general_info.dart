import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart';

import '../../../../../utils/app_assets.dart';
import '../../../domain/entities/card_model.dart';
import 'container_info.dart';
import 'custom_view.dart';

class HomeInfo extends StatelessWidget {
  HomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    List<CardModel> experience = [
      CardModel(
        image: Image.asset(AppAssets.experienceImg),
        title: 'Software Engineer',
        subtitle: 'Company Name',
        duration: 'Aug 2023 – Aug 2024',
        badge: 'Internship',
      ),
      CardModel(
        image: Image.asset(AppAssets.experienceImg),
        title: 'Backend Developer',
        subtitle: 'Other Company',
        duration: 'Jul 2022 – Jul 2023',
        badge: 'Full-time',
      ),
      CardModel(
        image: Image.asset(AppAssets.experienceImg),
        title: 'Mobile Developer',
        subtitle: 'Startup',
        duration: 'Jan 2021 – Jun 2022',
        badge: 'Part-time',
      ),
    ];
    List<CardModel> education = [
      CardModel(
        image: Image.asset(AppAssets.educationImg),
        title: 'Software Engineer',
        subtitle: 'Company Name',
        duration: 'Aug 2023 – Aug 2024',
      ),
    ];
    List<CardModel> courses = [
      CardModel(
        image: Image.asset(AppAssets.courseImg),
        title: 'Software Engineer',
        subtitle: 'IBM',
        duration: 'Aug 2023 – Aug 2024',
        badge: 'Internship',
      ),
      CardModel(
        image: Image.asset(AppAssets.courseImg),
        title: 'Backend Developer',
        subtitle: 'Other Company',
        duration: 'Jul 2022 – Jul 2023',
        badge: 'Full-time',
      ),
    ];
    List<CardModel> certificate = [
      CardModel(
        image: Image.asset(AppAssets.certificateImg),
        title: 'Software Engineer',
        subtitle: 'Company Name',
        duration: 'Aug 2023 – Aug 2024',
        badge: 'Link',
        isLink: true,
      ),
    ];
    List<String> lang = ['English', 'Arabic'];
    List<String> skills = ['React', 'JS', 'Communication'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brief Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Brief",
                style: theme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "We are looking for a motivated Corporate Solutions professional to join our team. In this role, you will build strong relationships with corporate clients, understand their unique needs, and deliver tailored solutions that drive business success.",
                style: theme.bodyLarge?.copyWith(
                  height: 1.5,
                  color: colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Experience",
                style: theme.titleMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              CustomInfoCard(info: experience),
              SizedBox(height: 16),
              Text(
                "Education",
                style: theme.titleMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              CustomInfoCard(info: education),
              SizedBox(height: 16),
              Text(
                "Courses",
                style: theme.titleMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              CustomInfoCard(info: courses),
              SizedBox(height: 16),
              Text(
                "Certificates",
                style: theme.titleMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              CustomInfoCard(info: certificate),
              SizedBox(height: 16),
              Text(
                "My Skills",
                style: theme.titleMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ContainerInfo(info: skills),
              SizedBox(height: 16),
              Text(
                "My Languages",
                style: theme.titleMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ContainerInfo(info: lang),
            ],
          ),
        ],
      ),
    );
  }
}
