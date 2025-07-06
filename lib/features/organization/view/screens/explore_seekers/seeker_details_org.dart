import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/app_assets.dart';
import '../../../../../utils/data_shared/shared_const_api.dart';
import '../../../domain/modules/seeker.dart';

class SeekerDetailsOrg extends StatelessWidget {
  final SeekerModel seeker;

  const SeekerDetailsOrg({super.key, required this.seeker});

  @override
  Widget build(BuildContext context) {
    print(seeker.photo);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Seeker Details", style: AppFonts.mainText),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8.r,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: seeker.photo == null || seeker.photo!.isEmpty
                          ? Image.asset(AppAssets.org_logo, width: 60.w, height: 60.h)
                          :
                      Image.network(
                        '${ApiShared.baseUrl}${seeker.photo}',
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Image.asset(AppAssets.org_logo, width: 60.w, height: 60.h);
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "${seeker.user?.firstName ?? ""} ${seeker.user?.lastName ?? ""}".trim(),
                      style: AppFonts.mainText.copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      seeker.title ?? "No Title Provided",
                      style: AppFonts.secMain.copyWith(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Personal Info
              _buildSection("Personal Info", [
                _buildRow(Icons.person, "Gender: ${seeker.gender ?? "N/A"}"),
                _buildRow(Icons.cake, "DOB: ${seeker.dob ?? "N/A"}"),
                _buildRow(Icons.phone, "Phone: ${seeker.phone ?? "Not provided"}"),
                _buildRow(Icons.email, "Email: ${seeker.user?.email ?? "Not provided"}"),
              ]),

              // Location Info
              _buildSection("Location", [
                _buildRow(Icons.location_on, "Country: ${seeker.country ?? "N/A"}"),
                _buildRow(Icons.location_city, "City: ${seeker.city ?? "N/A"}"),
              ]),

              // Career Info
              _buildSection("Career Info", [
                _buildRow(Icons.work_outline, "Career Level: ${seeker.careerLevel ?? "N/A"}"),
                _buildRow(Icons.business_center, "Employment Status: ${seeker.employmentStatus ?? "N/A"}"),
              ]),

              // Nationality
              if (seeker.nationality != null && seeker.nationality!.isNotEmpty)
                _buildSection("Nationality", [
                  _buildRow(Icons.flag, "Nationality: ${seeker.nationality}"),
                ]),

              // About Me
              if (seeker.brief != null && seeker.brief!.isNotEmpty)
                _buildSection("About Me", [
                  Text(
                    seeker.brief!,
                    style: AppFonts.textFieldStyle,
                    textAlign: TextAlign.justify,
                  ),
                ]),

              // Skills
              if ((seeker.skills?.isNotEmpty ?? false))
                _buildSection("Skills", [
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: seeker.skills!
                        .map((skill) => Chip(
                      label: Text(skill.skillName ?? "Unknown Skill"),
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                    ))
                        .toList(),
                  ),
                ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> content) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6.r,
            spreadRadius: 1.r,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppFonts.mainText.copyWith(fontSize: 18.sp)),
          Divider(color: AppColors.subPrimary2, height: 24.h),
          ...content,
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 18.r, color: AppColors.primary),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: AppFonts.textFieldStyle,
            ),
          ),
        ],
      ),
    );
  }
}