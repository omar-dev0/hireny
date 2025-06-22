import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';

class PersonalProfileAdmin extends StatelessWidget {
  const PersonalProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController secondNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.subPrimary,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.h,),
              Text("Personal Profile",style: AppFonts.mainText,),
              SizedBox(height: 20.h,),
              Text("First name*",style: AppFonts.secMain,),
              CustomTextField(hint: "Enter your first name",controller: firstNameController,),
              SizedBox(height: 20.h,),
              Text("Last name*",style: AppFonts.secMain,),
              CustomTextField(hint: "Enter your Last name",controller: secondNameController,),
              SizedBox(height: 20.h,),
              Text("Email",style: AppFonts.secMain,),
              CustomTextField(hint: "Enter your Email",controller: emailController,),
              SizedBox(height: 20.h,),
              Text("Password",style: AppFonts.secMain,),
              CustomTextField(hint: "***********",isPassword: true,maxLines: 1,controller: passwordController,),
              SizedBox(height: 60.h,),
              CustomButtom(title: "Save Changes ",onPressed: (){},)
            ],
          ),
        ),
      ),
    );
  }
}
