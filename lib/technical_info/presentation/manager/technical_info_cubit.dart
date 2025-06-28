import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/models/response/lang_model.dart';
import 'package:hireny/technical_info/data/models/response/skill_model.dart';
import 'package:hireny/technical_info/domain/usecases/delete_tech_info.dart';
import 'package:hireny/technical_info/domain/usecases/get_tech_info.dart';
import 'package:hireny/technical_info/domain/usecases/tech_usecase.dart';
import 'package:hireny/technical_info/domain/usecases/update_tech_info.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import 'package:file_picker/file_picker.dart';

import '../../data/models/response/certificate_model.dart';
import '../../data/models/response/course_model.dart';
import '../../data/models/response/education_model.dart';
import '../../data/models/response/experience_model.dart';
import '../../data/models/response/tech_info_respnonse.dart';

part 'technical_info_state.dart';

@injectable
class TechnicalInfoCubit extends Cubit<TechnicalInfoState> {
  final AddTechInfo _addEdu;
  final DeleteTechInfo _deleteTechInfo;
  final GetTechInfo _getTechInfo;
  final UpdateTechInfo _updateTechInfo;

  @factoryMethod
  TechnicalInfoCubit(this._addEdu, this._getTechInfo, this._deleteTechInfo, this._updateTechInfo)
      : super(TechnicalInfoInitial());

  bool isCourse = false;
  bool isCertificate = false;
  bool isEducation = false;
  bool isExperience = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedJobType;
  String? selectedJobTitle;


  final List<ExperienceModel> experiences = [];
  final List<Educations> education = [];
  final List<CourseModel> courses = [];
  final List<CertificateModel> certificates = [];
  final List<SkillModel> skills = [];
  final List<LanguageModel> languages = [];

  List<String> jobTitles = ['Software Engineer', 'Backend Developer', 'Mobile Developer'];
  List<String> jobTypes = ['Full-time', 'Part-time', 'Internship'];

  void setJobTitle(String title) {
    selectedJobTitle = title;
    emit(TechnicalInfoInitial());
  }

  void setJobType(String type) {
    selectedJobType = type;
    emit(TechnicalInfoInitial());
  }

  void setFormFlags({
    bool course = false,
    bool certificate = false,
    bool education = false,
    bool experience = false,
  }) {
    isCourse = course;
    isCertificate = certificate;
    isEducation = education;
    isExperience = experience;
  }
/// get
  Future<Result<TechInfoResponse>> getTechInfo() async {
    String? token = AppSharedData.user?.accessToken;
    emit(TechnicalInfoLoading());

    final result = await _getTechInfo.call(token!);

    switch (result) {
      case Success<TechInfoResponse>():
        final response = result.response;

        if (!checkEmptyList()) {
          //
        } else {
          emit(TechnicalInfoInitial());
        }

        response!.educations.forEach(education.add);
        response.certificates.forEach(certificates.add);
        response.courses.forEach(courses.add);
        response.experiences.forEach(experiences.add);
        response.languages.forEach(languages.add);
        response.skills.forEach(skills.add);

        emit(TechnicalInfoSuccess());
        return result;

      case Error<TechInfoResponse>():
        emit(TechnicalInfoFailure(result.error.toString()));
        return result;

      default:
        throw UnimplementedError();
    }
  }
/// add
  Future<Result<void>> addTechInfo() async {
    emit(TechnicalInfoLoading());

    try {
      dynamic dataToSend;
      int addID = -1;

      if (isCertificate) {
        isCertificate = false;
        dataToSend = CertificateModel(
          id: certificates.isNotEmpty ? certificates.last.id + 1 : 1,
          certificateName: titleController.text,
          institutionName: institutionController.text,
          dateIssued: startDateController.text,
          description: descriptionController.text,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );
      } else if (isCourse) {
        isCourse = false;
        dataToSend = CourseModel(
          id: courses.isNotEmpty ? courses.last.id + 1 : 1,
          courseName: titleController.text,
          institutionName: institutionController.text,
          dateCompleted: startDateController.text,
          description: descriptionController.text,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          user: AppSharedData.user?.id,
        );
      } else if (isEducation) {
        isEducation = false;
        dataToSend = Educations(
          id: education.isNotEmpty ? education.last.id + 1 : 1,
          institutionName: institutionController.text,
          degree: titleController.text,
          fromDate: startDateController.text,
          toDate: endDateController.text,
          description: descriptionController.text,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          user: AppSharedData.user?.id,
        );
      } else if (isExperience) {
        isExperience = false;
        dataToSend = ExperienceModel(
          id: experiences.isNotEmpty ? experiences.last.id + 1 : 1,
          companyName: institutionController.text,
          jobTitle: selectedJobTitle ?? '',
          jobType: selectedJobType ?? '',
          fromDate: startDateController.text,
          toDate: endDateController.text,
          description: descriptionController.text,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          user: AppSharedData.user?.id,
        );
      }

      addID = _getID(dataToSend);


      final result = await _addEdu.call(dataToSend, addID);

      if (result is Success<void>) {
        await getTechInfo();
        emit(TechnicalInfoSuccess());
      } else if (result is Error<void>) {
        emit(TechnicalInfoFailure(result.error));
      }

      return result;
    } catch (e) {
      final error = "Exception occurred while adding tech info: $e";
      emit(TechnicalInfoFailure(error));
      return Error(error: error);
    }
  }
/// delete
  Future<Result<void>> deleteItem(String id, dynamic type) async {
    int deleteID = _getID(type);

    try {
      emit(TechnicalInfoLoading());

      final result = await _deleteTechInfo.call(id, deleteID);

      if (result is Success<void>) {
        await getTechInfo();
        emit(TechnicalInfoSuccess()); // Ensure UI updates even if same data
        return result;
      } else if (result is Error<void>) {
        emit(TechnicalInfoFailure(result.error));
        return result;
      }

      return result;
    } catch (e) {
      emit(TechnicalInfoFailure("Exception occurred while deleting item: $e"));
      return Error(error: e.toString());
    }
  }
/// update
  Future<Result<void>> updateTechInfo(String itemID, dynamic data) async {
    emit(TechnicalInfoLoading());

    try {
      dynamic dataToSend;
      int updateID = _getID(data);


      // Build the correct updated data model
      if (data is CertificateModel) {
        dataToSend = CertificateModel(
          id: data.id,
          certificateName: titleController.text,
          institutionName: institutionController.text,
          dateIssued: startDateController.text,
          description: descriptionController.text,
          createdAt: data.createdAt,
          updatedAt: DateTime.now().toIso8601String(),
        ).toJson();
      } else if (data is CourseModel) {
        dataToSend = CourseModel(
          id: data.id,
          courseName: titleController.text,
          institutionName: institutionController.text,
          dateCompleted: startDateController.text,
          description: descriptionController.text,
          createdAt: data.createdAt,
          updatedAt: DateTime.now().toIso8601String(),
          user: AppSharedData.user?.id,
        ).toJson();
      } else if (data is Educations) {
        dataToSend = Educations(
          id: data.id,
          institutionName: institutionController.text,
          degree: titleController.text,
          fromDate: startDateController.text,
          toDate: endDateController.text,
          description: descriptionController.text,
          createdAt: data.createdAt,
          updatedAt: DateTime.now().toIso8601String(),
          user: AppSharedData.user?.id,
        ).toJson();
      } else if (data is ExperienceModel) {
        dataToSend = ExperienceModel(
          id: data.id,
          companyName: institutionController.text,
          jobTitle: selectedJobTitle ?? '',
          jobType: selectedJobType ?? '',
          fromDate: startDateController.text,
          toDate: endDateController.text,
          description: descriptionController.text,
          createdAt: data.createdAt,
          updatedAt: DateTime.now().toIso8601String(),
          user: AppSharedData.user?.id,
        ).toJson();
      }
      updateID = _getID(data);

      final result = await _updateTechInfo.call(itemID, dataToSend, updateID);

      if (result is Success<void>) {
        await getTechInfo();
        emit(TechnicalInfoSuccess());
      } else if (result is Error<void>) {
        print(result.error);
        emit(TechnicalInfoFailure(result.error));
      }

      return result;
    } catch (e) {
      final error = "Exception occurred while updating tech info: $e";
      emit(TechnicalInfoFailure(error));
      return Error(error: error);
    }
  }
  int _getID(dynamic type) {
    if (type is CertificateModel) return 2;
    if (type is Educations) return 3;
    if (type is ExperienceModel) return 4;
    if (type is CourseModel) return 1;
    return -1;
  }

  void setFlagByTitle(String title) {
  isCourse = false;
    isCertificate = false;
    isEducation = false;
    isExperience = false;

    if (title == "My Certificate") isCertificate = true;
    else if (title == "My Courses") isCourse = true;
    else if (title == "My Education") isEducation = true;
    else if (title == "My Experience") isExperience = true;

    emit(TechnicalInfoInitial());
  }

  bool checkEmptyList() {
    return education.isNotEmpty ||
        languages.isNotEmpty ||
        certificates.isNotEmpty ||
        experiences.isNotEmpty ||
        courses.isNotEmpty ||
        skills.isNotEmpty;
  }

  Future<void> pickCVFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        String filePath = result.files.single.path!;
        emit(TechnicalInfoSuccess());
        print("File path: $filePath");
      }
    } catch (e) {
      emit(TechnicalInfoFailure(e.toString()));
      print("No file selected");
    }
  }
}
