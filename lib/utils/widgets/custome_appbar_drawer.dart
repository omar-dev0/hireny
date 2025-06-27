import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class CustomScreen extends StatelessWidget {
  final String title;
  final Widget drawer;
  final Widget body;
  final bool centerTitle;

  const CustomScreen({
    Key? key,
    required this.title,
    required this.drawer,
    required this.body,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white), // White drawer icon
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.white
          ),
        ),
        centerTitle: centerTitle,
        backgroundColor: AppColors.primary,
      ),
      drawer: drawer,
      body: body,
    );
  }
}

