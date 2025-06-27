import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/models/response/lang_model.dart';
import 'package:hireny/technical_info/data/models/response/skill_model.dart';
import 'package:hireny/technical_info/domain/usecases/delete_tech_info.dart';
import 'package:hireny/technical_info/domain/usecases/get_tech_info.dart';

import 'package:hireny/technical_info/domain/usecases/tech_usecase.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:file_picker/file_picker.dart';
import '../../../models/technical info.dart';
import '../../data/models/response/certificate_model.dart';
import '../../data/models/response/course_model.dart';
import '../../data/models/response/education_model.dart';
import '../../data/models/response/experience_model.dart';
import '../../data/models/response/tech_info_respnonse.dart';

part 'technical_info_state.dart';
@injectable

class TechnicalInfoCubit extends Cubit<TechnicalInfoState> {
  AddEdu _addEdu;
  DeleteTechInfo _deleteTechInfo;
  GetTechInfo _getTechInfo;

  @factoryMethod
  TechnicalInfoCubit(this._addEdu,this._getTechInfo,this. _deleteTechInfo) : super(TechnicalInfoInitial());



  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _startingYear = TextEditingController();
  final TextEditingController _endingYear = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // todo try to move to data source
  final List<ExperienceModel> experiences=[];
  final List<Educations> education=[];
  final List<CourseModel> courses=[];
  final List<CertificateModel> certificates=[];
  final List<SkillModel> skills=[];
  final List<LanguageModel> languages=[];
  /// get
  Future<Result<TechInfoResponse>> getTechInfo() async {
    String? token = AppSharedData.user?.accessToken;
    emit(TechnicalInfoLoading());
    final result = await _getTechInfo.call(token!);

    switch (result) {
      case Success<TechInfoResponse>():
        final response = result.response;
        if (!checkEmptyList()) {
          education.clear();
          certificates.clear();
          courses.clear();
          experiences.clear();
          languages.clear();
          skills.clear();
        }
        response!.educations.forEach((e) {
          education.add(e);
        });

        response.certificates.forEach((c) {
          certificates.add(c);
          print("Added Certificate: ${c.certificateName}");
        });

        response.courses.forEach((c) {
          courses.add(c);
          print("Added Course: ${c.id}");
        });

        response.experiences.forEach((e) {
          experiences.add(e);
          print("Added Experience: ${e.jobTitle}");
        });

        response.languages.forEach((l) {
          languages.add(l);
          print("Added Language: ${l.languageName}");
        });

        response.skills.forEach((s) {
          skills.add(s);
          print("Added Skill: ${s.skillName}");
        });


        emit(TechnicalInfoSuccess());
        return result;

      case Error<TechInfoResponse>():
        final error = result.error;
        print("❌ Error while fetching tech info: $error");
        emit(TechnicalInfoFailure(error.toString()));
        return result;
      case Success<void>():
      // TODO: Handle this case.
        throw UnimplementedError();
      case Error<void>():
      // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
  /// delete
  Future<Result<void>> deleteItem(String id, dynamic type)async{
    int deleteID = -1;
    if(type is CertificateModel){
      deleteID = 2;
    }else if(type is Educations){
      deleteID = 3;
    }else if(type is ExperienceModel){
      deleteID =4;
    }else if(type is CourseModel){
      deleteID = 1;
    }
      print("Deleting type: ${type.runtimeType} with id: $id");

    try{
      emit(TechnicalInfoLoading());
      final result = await _deleteTechInfo .call(id,deleteID);
    if (result is Success<void>) {
      emit(TechnicalInfoSuccessDeleted());
    } else if (result is Error<void>) {
      emit(TechnicalInfoFailure(result.error));

    }
    return result;
  } catch(e) {
  emit(TechnicalInfoFailure("Exception occurred while deleting item: $e"));
  return Error(error: e.toString());
  }
  }

  //
  // void addExperience()
  // {
  //   try{
  //     Map<String, dynamic> map = {
  //       'title': _nameController,
  //       'organization': _companyController,
  //       'startDate': _startingYear,
  //       'endDate': _endingYear,
  //     };
  //     ExperienceModel exp = ExperienceModel.fromMap(map);
  //     experiences.add(exp);
  //     emit(TechnicalInfoSuccess());
  //
  //   }
  //   catch(e)
  //   {
  //     emit(TechnicalInfoFailure(e.toString()));
  //
  //   }
  // }
  // void updateExperience({required int id})
  // {
  //
  //   for(int i=0; i<experiences.length;i++)
  //     {
  //       try
  //       {
  //         if (experiences[i].id == id )
  //         {
  //           experiences[i].title = (_nameController?.value)?.toString() ?? experiences[i].title;
  //           experiences[i].endDate = (_endingYear?.value)?.toString() ?? experiences[i].endDate;
  //           experiences[i].startDate = (_startingYear?.value)?.toString() ?? experiences[i].startDate;
  //           experiences[i].organization = (_companyController?.value)?.toString() ?? experiences[i].organization;
  //           emit(TechnicalInfoSuccess());
  //           break;
  //         }
  //       }catch(e)
  //       {
  //         emit(TechnicalInfoFailure(e.toString()));
  //       }
  //
  //     }
  // }
  void deleteEXperience({required int id})
  {
    for(int i=0; i<experiences.length;i++)
    {
      try
      {
        if (experiences[i].id == id )
        {
          experiences.remove(experiences[i]);
          emit(TechnicalInfoSuccess());
          break;
        }
      }catch(e)
      {
        emit(TechnicalInfoFailure(e.toString()));
      }

    }

  }

  // Future<TechnicalInfo> getEduction()
  // {
  //
  // }
  bool checkEmptyList(){
    int cnt = 0;
    if(education.isNotEmpty){
      cnt++;
    }else if(languages.isNotEmpty){
     cnt++;
    }else if(certificates.isNotEmpty){
      cnt++;
    }else if(experiences.isNotEmpty){
      cnt++;
    }else if(courses.isNotEmpty){
      cnt++;
    }else if(skills.isNotEmpty){
      cnt++;
    }
      if(cnt!=0){
        return true;
      }
    return false;
  }
  // todo add education
  // Future<Result<void>> addEducation() async {
  //   emit(TechnicalInfoLoading());
  //   // final model = Educations(
  //   //    title: _nameController.text,
  //   //     organization: '',
  //   //     startDate: '',
  //   //     endDate: '',
  //   //     description:'', id: nun:''institutionName: '', degree: '', fromDate: '', toDate: '', createdAt: '', updatedAt: '', user: null
  //   //
  //   // );
  //   try {
  //     final result = await addEdu.call(model);
  //
  //     if (result is Success<void>) {
  //       emit(TechnicalInfoSuccess());
  //     } else if (result is Error<void>) {
  //       emit(TechnicalInfoFailure(result.error));
  //     }
  //
  //     return result;
  //   } catch (e) {
  //     final error = e.toString();
  //     emit(TechnicalInfoFailure(error));
  //     return Error();
  //   }
  // }

  void updateEduction()
  {

  }
  void deleteEduction()
  {

  }

  // Future<TechnicalInfo> getCourses()
  // {
  //
  // }
  void addCourse()
  {

  }
  void updateCourse()
  {

  }
  void deleteCourse()
  {

  }

  // Future<TechnicalInfo> getCertificate()
  // {
  //
  // }
  void addCertificate()
  {

  }
  void updateCertificate()
  {

  }
  void deleteCertificate()
  {

  }

  // Future<TechnicalInfo> getLangs()
  // {
  //
  // }
  void addLang()
  {

  }
  void updateLang()
  {

  }
  void deleteLang()
  {

  }

  // Future<TechnicalInfo> getSkills()
  // {
  //
  // }
  void addSkill()
  {

  }
  void updateSkill()
  {

  }
  void deleteSkill()
  {

  }

  Future<void> pickCVFile() async {
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        String filePath = result.files.single.path!;
        emit(TechnicalInfoSuccess());
        print("File path: $filePath");
    }
      // profile.cvFilePath = filePath;
    } catch(e){
      emit(TechnicalInfoFailure(e.toString()));
      // User canceled the picker
      print("No file selected");
    }
  }


}
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwOTg0NDExLCJpYXQiOjE3NTA5NDEyMTEsImp0aSI6IjQ5NDdiMjEzZDFiODRlMzBhNzhkZGEyYjBmMjU3MjIyIiwidXNlcl9pZCI6MzAsImlkIjozMCwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3QxMjNAZ21haWwuY29tIiwicm9sZSI6InNlZWtlciIsInBob3RvIjoiL21lZGlhL3Bob3Rvcy9kZWZhdWx0LnBuZyJ9.4zg1ePGtSqhmrNrQJsz3gbf6dGZl6mpmno4iRIsxfmk