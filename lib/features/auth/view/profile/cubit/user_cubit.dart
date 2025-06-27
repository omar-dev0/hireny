import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/linkes/link.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/profile/cubit/user_states.dart';
import 'package:hireny/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../utils/data_shared/app_shared_data.dart';
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
  //---------------------------
  final resetPasswordController = TextEditingController();
  final confirmResetPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  //---------------------------
  TextEditingController titleController = TextEditingController();
  TextEditingController briefController = TextEditingController();
  String? selectedCareerLevel;
  String? selectedEmploymentStatus;
  int counter = 1;
  final List<String> linkTypes = ['GitHub', 'LinkedIn', 'Behance'];
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
  final List<Map<String, dynamic>> fieldPairs = [];

  String? phoneNumber;
  String? countryValue;
  String? cityValue;
  String? stateValue;
  String? selectedGender;
  String? selectedLinkType;

  // get user info
  Future<User?> getUserInfo() async {
    String? token = AppSharedData.user?.accessToken;
    emit(LoadingState());
    final result = await _repoAuth.getUserInfo(token!);

    switch (result) {
      case Success<User?>():
        final user = result.response;

        if (user == null) {
          emit(ErrorUpdatedState("User data is null"));
          return null;
        }

        firstNameController.text = user.firstName ?? '';
        lastNameController.text = user.lastName ?? '';
        emailController.text = user.email ?? '';
        // problem -> country code + phone num
        phoneController.text = user.phone ?? '';
        country = user.country;
        city = user.city;

        if (user is Seeker) {
          selectedGender = user.gender;
          titleController.text = user.title ?? '';
          briefController.text = user.brief ?? '';
          selectedCareerLevel = user.careerLevel;
          selectedEmploymentStatus = user.employmentStatus;
          birthDateController.text = user.dob ?? '';
          for (var link in user.links ?? []) {
            final type = link['type']?.toString() ?? '';
            final url = link['url']?.toString() ?? '';
            fieldPairs.add({
              'type': type,
              'link': TextEditingController(text: url),
            });
          }
          for (var pair in fieldPairs) {
            final type = pair['type'];
            final url = pair['link'];
            print('Link Type: $type, URL: $url');
          }
        }
        emit(SuccessUpdatedState());
        return user;

      case Error<User?>():
        emit(ErrorUpdatedState(result.error ?? "Failed to fetch user info"));
        return null;

      default:
        emit(ErrorUpdatedState("Unknown error occurred"));
        return null;
    }
  }

  // change password
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

  // image picker logic
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

  int getLen() {
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
    final dateRegex = RegExp(
      r'^([0-2][0-9]|(3)[0-1])/(0[1-9]|1[0-2])/([0-9]{4})$',
    );
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

  void loadData() {
    //link list
    if (AppSharedData.user is Seeker) {
      final seeker = AppSharedData.user as Seeker;
      firstNameController.text = seeker.firstName ?? '';
      lastNameController.text = seeker.lastName ?? '';
      emailController.text = seeker.email ?? '';
      selectedGender = seeker.gender;
      titleController.text = seeker.title ?? '';
      briefController.text = seeker.brief ?? '';
      selectedCareerLevel = seeker.careerLevel;
      selectedEmploymentStatus = seeker.employmentStatus;
      birthDateController.text = seeker.dob ?? '';
      phoneController.text = seeker.phone ?? '';
      city = seeker.city;
      country = seeker.country;
      selectedGender = seeker.gender;
      briefController.text = seeker.brief ?? '';
    }
  }
}
