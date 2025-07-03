import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/linkes/link.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/reg/cubit/state/reg_states.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../utils/lang/lang.dart';
import '../../../domain/modules/org/org_admin.dart';
import '../../../domain/modules/user/user.dart';

@injectable
class RegSeekerVm extends Cubit<RegState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController websiteLink = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController orgName = TextEditingController();
  final TextEditingController orgCeo = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String? industry;
  final TextEditingController briefController = TextEditingController();
  RepoAuth repoAuth;
  DateTime? date;
  bool sendMeEmail = false;
  String? gender;
  String dob = "YYYY-MM-DD";
  String? nationality;
  String? city;
  String? country;
  String? careerLevel;
  String? employmentStatus;
  String? brief;
  bool? immediateStar = false;
  File? cv;
  String fileName = "";
  File? photo;
  final titleController = TextEditingController();
  @factoryMethod
  RegSeekerVm(this.repoAuth) : super(InitReg());
  String? orgSize;

  Future<void> pickAndReadFile() async {
    emit(LoadingReg());
    _requestStoragePermission();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    emit(HideRegLoading());
    if (result != null && result.files.isNotEmpty) {
      fileName = result.files.single.name;
      cv = File(result.files.single.path!);
    }
  }

  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  String? checkValidConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return "Confirm password can't be empty";
    }
    if (value != password.text) {
      return "Passwords don't match";
    }
    return null;
  }

  Future<void> regSeeker() async {
    if (formKey.currentState!.validate() && _checkValidSeekerInput()) {
      emit(LoadingReg());
      try {
        Seeker seeker = Seeker(
          firstName: firstName.text,
          lastName: lastName.text,
          email: email.text,
          phone: phone.text,
          role: "seeker",
          country: country,
          city: city,
          dob: dob,
          gender: gender,
          title: titleController.text,
          nationality: nationality,
          careerLevel: careerLevel,
          employmentStatus: employmentStatus,
          brief: briefController.text,
          immediateStart: immediateStar,
          updatesToEmail: sendMeEmail,
        );
        if (cv != null) {
          seeker.cv = await User.encodeFileToBase64(cv!);
        }
        if (photo != null) {
          seeker.photo = await User.encodeFileToBase64(photo!);
        }
        Result<Seeker?>? result = await repoAuth.regSeeker(
          seeker,
          password.text,
          cv,
        );
        switch (result) {
          case null:
            {
              emit(HideRegLoading());
              emit(RegError(message: "Something went wrong"));
            }
          case Success<Seeker?>():
            {
              emit(HideRegLoading());
              emit(RegSuccess());
            }
          case Error<Seeker?>():
            {
              emit(HideRegLoading());
              emit(RegError(message: 'email already exists'));
            }
        }
      } catch (e) {
        emit(HideRegLoading());
        print(e);
        emit(RegError(message: e.toString()));
      }
    }
  }

  Future<void> regOrg() async {
    if (formKey.currentState!.validate() && _checkValidOrgInput()) {
      emit(LoadingReg());
      try {
        OrgAdmin orgAdmin = OrgAdmin(
          firstName: firstName.text,
          lastName: lastName.text,
          email: email.text,
          phone: phone.text,
          role: "orgAdmin",
          country: country,
          city: city,
          startYear: dob,
          companyName: orgName.text,
          ceo: orgCeo.text,
          industry: industry,
          orgSize: orgSize,
          updatesToEmail: sendMeEmail,
          links: [UserLink(type: 'website', url: websiteLink.text)],
          photo: null,
        );
        Result<OrgAdmin?>? result = await repoAuth.regOrg(
          orgAdmin,
          password.text,
          cv,
        );
        switch (result) {
          case null:
            {
              emit(HideRegLoading());
              emit(RegError(message: "Something went wrong"));
            }
          case Success<OrgAdmin?>():
            {
              emit(HideRegLoading());
              emit(RegSuccess());
            }
          case Error<OrgAdmin?>():
            {
              emit(HideRegLoading());
              print(result.error);
              emit(RegError(message: 'email already exists'));
            }
        }
      } catch (e) {
        print(e);
        emit(HideRegLoading());
        emit(RegError(message: Lang.emailExists));
      }
    }
  }

  bool _checkValidSeekerInput() {
    if (date == null) {
      emit(ValidateDate());
      return false;
    }
    // if (cv == null) {
    //   emit(ValidateFile());
    //   return false;
    // }
    if (gender == null) {
      emit(ValidateGender());
      return false;
    }
    if (nationality == null) {
      emit(ValidateNationality());
      return false;
    }
    if (country == null) {
      emit(ValidateCountry());
      return false;
    }
    if (city == null) {
      emit(ValidateCity());
      return false;
    }
    if (careerLevel == null) {
      emit(ValidateCareerLevel());
      return false;
    }
    if (employmentStatus == null) {
      emit(ValidateEmploymentStatus());
      return false;
    }

    return true;
  }

  bool _checkValidOrgInput() {
    if (date == null) {
      emit(ValidateDate());
      return false;
    }
    // if (cv == null) {
    //   emit(ValidateFile());
    //   return false;
    // }
    if (industry == null) {
      emit(ValidateIndestry());
      return false;
    }
    if (orgSize == null) {
      emit(ValidateOrgSize());
      return false;
    }
    if (country == null) {
      emit(ValidateCountry());
      return false;
    }
    if (city == null) {
      emit(ValidateCity());
      return false;
    }

    return true;
  }
}
