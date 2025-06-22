import 'package:flutter/material.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/views/salary_insights/salary_insights_screen.dart';

import '../utils/constants/app_colors.dart';

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          title: Text("Hireny",style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w500
          ),),
          actions: [
            IconButton(
              icon:  Icon(Icons.notifications,color: AppColors.white,),
              onPressed: () {
                // TODO: Handle notification tap
              },
            ),
            IconButton(
              icon:  Icon(Icons.person,color: AppColors.white,),
              onPressed: () {
                Navigator.pushReplacementNamed(context, PagesRoute.generalInfo);
              },
            ),
          ],
          bottom:  TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 16),
            labelColor: AppColors.white,
            tabAlignment: TabAlignment.start,
            unselectedLabelColor: AppColors.white,
            indicatorColor: AppColors.white,
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Jobs'),
              Tab(text: 'Organizations'),
              Tab(text: 'Courses'),
              Tab(text: 'Insights'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('This is Home Tab')),
            Center(child: Text('This is Jobs Tab')),
            Center(child: Text('This is Organizations Tab')),
            Center(child: Text('This is Courses Tab')),
            SalaryInsightsScreen()

          ],
        ),
      ),
    );
  }
}
