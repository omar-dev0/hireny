import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/profile/cubit/user_states.dart';
import 'package:hireny/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../utils/data_shared/app_shared_data.dart';
import '../../../domain/modules/linkes/link.dart';
import '../../../domain/modules/seeker/seeker.dart';
import '../../../domain/modules/user/user.dart';

@injectable
class UserCubit extends Cubit<UserStates> {
  @factoryMethod
  RepoAuth _repoAuth;
  UserCubit(this._repoAuth) : super(InitialState());
  File? selectedImage;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formTechKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? city;
  String? country;
  int linksLen = 0;
  //---------------------------
  final resetPasswordController = TextEditingController();
  final confirmResetPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  //---------------------------
  TextEditingController titleController = TextEditingController();
  TextEditingController briefController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCareerLevel;
  String? selectedEmploymentStatus;
  int counter = 1;
  final List<String> linkTypes = ['GitHub', 'LinkedIn', 'Behance'];
  final List<Map<String, dynamic>> fieldPairs = [];

  String? phoneNumber;
  String? countryValue;
  String? cityValue;
  String? stateValue;
  String? selectedGender;
  String? selectedLinkType;
//=================================================
  /// org account
  TextEditingController nameController = TextEditingController();
  TextEditingController ceoController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();
  String? industry;
  String? orgSize;
  bool updated = false;
  void setIndustry(String value){
    industry = value;
    emit(SuccessUpdatedState());
  }
  void setOrgSize(String value){
    orgSize = value;
    emit(SuccessUpdatedState());
  }
//=================================================

  /// get user info
  void loadData() {
    // Ensure the user is a Seeker
    if (AppSharedData.user is Seeker) {
      final seeker = AppSharedData.user as Seeker;

      // Fill basic profile fields
      firstNameController.text = seeker.firstName ?? '';
      lastNameController.text = seeker.lastName ?? '';
      emailController.text = seeker.email ?? '';
      phoneController.text = seeker.phone ?? '';
      selectedGender = seeker.gender;
      titleController.text = seeker.title ?? '';
      briefController.text = seeker.brief ?? '';
      selectedCareerLevel = seeker.careerLevel;
      selectedEmploymentStatus = seeker.employmentStatus;
      birthDateController.text = seeker.dob ?? '';
      city = seeker.city;
      country = seeker.country;

      // ✅ Clear and load social links
      fieldPairs.clear();
      for (UserLink? link in seeker.links) {
        print('🔗 Link added -> type: ${link?.type}, url: ${link?.url}');
        fieldPairs.add({
          'type': link?.type,
          'value': TextEditingController(text: link?.url ?? ''),
        });
      }

      emit(SuccessUpdatedState());
    }
    if (AppSharedData.user is OrgAdmin) {
      final org = AppSharedData.user as OrgAdmin;
      nameController.text = org.companyName ?? '';
      ceoController.text = org.ceo ?? '';
      phoneController.text = org.phone ?? '';
      emailController.text = org.email ?? '';
      birthDateController.text = org.startYear?.toString() ?? '';
      city = org.city;
      industry = org.industry;
      orgSize = org.orgSize;
      if(org.updatesToEmail!){
        updated=true;
      }

      fieldPairs.clear();
      for (UserLink? link in org.links) {
        fieldPairs.add({
          'type': link?.type,
          'value': TextEditingController(text: link?.url ?? ''),
        });
      }
    }
  }
  /// update user info
  Future<void> updateUserInfo() async {
    // Form validation
    if (!formKey.currentState!.validate()) return;

    emit(LoadingState());

    final String? token = AppSharedData.user?.accessToken;
    if (token == null) {
      emit(ErrorUpdatedState("Missing token"));
      return;
    }

    // ✅ Map social links
    final List<UserLink> links = fieldPairs.map((pair) {
      final type = pair['type'];
      final controller = pair['value'] as TextEditingController?;
      return UserLink(
        type: type ?? '',
        url: controller?.text.trim() ?? '',
      );
    }).toList();

    // ✅ Create updated Seeker model
    final seeker = Seeker(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      dob: birthDateController.text.trim(),
      gender: selectedGender,
      title: titleController.text.trim(),
      nationality: country,
      careerLevel: selectedCareerLevel,
      employmentStatus: selectedEmploymentStatus,
      brief: briefController.text.trim(),
      country: country,
      city: city,
      immediateStart: true,
      updatesToEmail: true,
      links: links,
      photo: null,
      cv: null,
    );

    // ✅ Call update API
    final result = await _repoAuth.updateUserInfo(seeker);


    switch (result) {
      case Success():
        emit(SuccessUpdatedState());
        break;
      case Error():
        emit(ErrorUpdatedState(result.error ?? "Update failed"));
        break;
    }
  }

  /// change password
  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    final oldPassword = oldPasswordController.text.trim();
    final newPassword = resetPasswordController.text.trim();
    final confirmPassword = confirmResetPasswordController.text.trim();
    // check if old password correct or not
    if (newPassword != confirmPassword) {
      emit(ErrorUpdatedState("Passwords do not match"));
      return;
    }

    final token = AppSharedData.user?.accessToken;

    emit(LoadingState());
    final result = await _repoAuth.changePassword(
      token!,
      oldPassword,
      newPassword,
    );
    switch (result) {
      case Success():
        emit(SuccessUpdatedState());
        break;
      case Error():
        emit(ErrorUpdatedState("Old password is incorrect"));
        break;
    }
  }

  /// image picker logic
  Future onPickImage(ImageSource source) async {
    ImagePicker imgPicker = ImagePicker();
    var image = await imgPicker.pickImage(source: source);
    selectedImage = File(image!.path);
    if (selectedImage != null) {
      emit(SuccessUpdatedState());
    } else {
      emit(ErrorUpdatedState("Failed to pick image"));
    }
  }

  /// updated gender
  void updateGender(String? gender) {
    selectedGender = gender;
    emit(SuccessUpdatedState());

  }

  void setEmploymentStatus(String? value) {
    selectedEmploymentStatus = value;
    emit(SuccessUpdatedState());
  }

  void setLinkType(String? value) {
    selectedLinkType = value;
    emit(SuccessUpdatedState());
  }

  void setCareerLevel(String? value) {
    selectedCareerLevel = value;
    emit(SuccessUpdatedState());
  }

  void addFieldPair() {
    fieldPairs.add({
      'type': null,
      'value': TextEditingController(),
    });
    emit(SuccessUpdatedState());
  }

  void removeFieldPair(int index) {
    fieldPairs[index]['value']?.dispose();
    fieldPairs.removeAt(index);
    emit(SuccessUpdatedState());
  }



  // validations
  String? validateText(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Only letters and spaces are allowed';
    }
    return null;
  }
// todo check why not validate correctly
  String? validateDate(String? value) {
    final parts = value?.split('-');
    final year = int.parse(parts![0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);


    final parsedDate = DateTime(year, month, day);
    print("✅ Parsed Date: $parsedDate");
    print("✅ Parsed Date: ${parsedDate.runtimeType}");

    final dateRegex = RegExp(r'^(20\d{2})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');

    if (value == null || value.isEmpty) {
      return 'Date is required';
    }

    if (!dateRegex.hasMatch(value)) {
      return 'Enter a valid date in yyyy-mm-dd format';
    }

    try {


      if (parsedDate.year != year || parsedDate.month != month || parsedDate.day != day) {
        return 'Invalid date';
      }
    } catch (e) {
      return 'Invalid date format';
    }

    return null;
  }


  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!passwordRegex.hasMatch(value)) {
      return 'Password not strong';
    }
    return null;
  }

  String? validateResetPassword(String? value) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!passwordRegex.hasMatch(value)) {
      return 'Password not strong';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != resetPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateDropList(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please select your $fieldName';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    final onlyDigitsRegex = RegExp(r'^\d+$');
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!onlyDigitsRegex.hasMatch(value)) {
      return 'Only numbers are allowed';
    }
    return null;
  }

  String? validateLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a link';
    }
    final pattern = RegExp(r'^(https?|ftp)://[^\s/$.?#].[^\s]*$');

    if (!pattern.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }

}