import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/user_accout/presentation/cubit/user_states.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserStates>{
  UserCubit():super(InitialState());
  // attributes
  File? selectedImage;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formTechKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  //---------------------------
  TextEditingController titleController = TextEditingController();
  TextEditingController briefController = TextEditingController();
  String? selectedCareerLevel;
  String? selectedEmploymentStatus;
  int counter = 1;
  final List<String> linkTypes = [
    'GitHub',
    'LinkedIn',
    'Behance'
  ];

  final List<String> careerLevels = [
    'Internship',
    'Entry Level',
    'Junior',
    'Mid Level',
    'Senior',
    'Lead',
    'Manager',
    'Director',
    'Executive',
  ];
  final List<String> employmentStatusList = [
    'Employed',
    'Unemployed',
    'Self-Employed',
    'Freelancer',
    'Student',
    'Intern',
    'Looking for Opportunities',
    'Not Looking for Opportunities',
    'Retired',
  ];
  final List<Map<String, TextEditingController>> fieldPairs = [];



  String? phoneNumber;
  String? countryValue;
  String? cityValue;
  String? stateValue;
  String? selectedGender;
  String? selectedLinkType;



  // image picker logic
  Future onPickImage() async {
    ImagePicker imgPicker = ImagePicker();
    var image = await imgPicker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    if(selectedImage != null){
      emit(SuccessUpdatedState());
    }else {
      emit(ErrorUpdatedState("Failed to pick image"));
    }
    }
  // updated gender
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
        'linkType': TextEditingController(),
        'link': TextEditingController(),
    });
      emit(SuccessUpdatedState());

  }
  void removeFieldPair(int index) {
      fieldPairs[index]['linkType']?.dispose();
      fieldPairs[index]['link']?.dispose();
      fieldPairs.removeAt(index);
      emit(SuccessUpdatedState());
  }

  int getLen(){
    return fieldPairs.length;
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
  String? validateDate(String? value) {
    final dateRegex = RegExp(r'^([0-2][0-9]|(3)[0-1])/(0[1-9]|1[0-2])/([0-9]{4})$');
    if (value == null || value.isEmpty) {
      return 'Please enter birth of date';
    }
    if (!dateRegex.hasMatch(value)) {
      return 'Enter a valid date (DD/MM/YYYY)';
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
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!passwordRegex.hasMatch(value)) {
      return 'Password not strong';
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
    print(value);
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
