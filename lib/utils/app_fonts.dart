import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireny/utils/app_colors.dart';
import 'package:hireny/utils/extensions/font_size.dart';

abstract class AppFonts {
  static TextStyle mainText = GoogleFonts.poppins(
    fontSize: 24.cSp,
    color: AppColors.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle secMain = GoogleFonts.poppins(
    color: AppColors.grey,
    fontSize: 18.cSp,
  );
  static TextStyle textFieldStyle = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 16.cSp,
  );
  static TextStyle hintStyle = GoogleFonts.poppins(
    color: AppColors.hintColor,
    fontSize: 14.cSp,
  );
  static TextStyle buttonTextStyle = GoogleFonts.poppins(
    color: AppColors.white,
    fontSize: 23.cSp,
  );
}
