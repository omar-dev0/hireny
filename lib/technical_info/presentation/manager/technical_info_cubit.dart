import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:file_picker/file_picker.dart';
import '../../../models/technical info.dart';

part 'technical_info_state.dart';

class TechnicalInfoCubit extends Cubit<TechnicalInfoState> {
  TechnicalInfoCubit() : super(TechnicalInfoInitial());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _CompanyController = TextEditingController();
  final TextEditingController _startingYear = TextEditingController();
  final TextEditingController _endingYear = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<ExperienceModel> experiences=
  [
    new ExperienceModel(title: "Software Engineer", organization: "Google", startDate: "2022", endDate: "2025", type: "internship")
  ];
  final List<EducationModel> education=[];
  final List<CourseModel> courses=[];
  final List<CertificateModel> certificates=[];
  final List<String> skills=[];
  final List<String> languages=[];

  // Future<TechnicalInfo> getExperiences()
  // {
  //
  // }
  void addExperience()
  {
    try{
      Map<String, dynamic> map = {
        'title': _nameController,
        'organization': _CompanyController,
        'startDate': _startingYear,
        'endDate': _endingYear,
      };
      ExperienceModel exp = ExperienceModel.fromMap(map);
      experiences.add(exp);
      emit(TechnicalInfoSuccess());

    }
    catch(e)
    {
      emit(TechnicalInfoFailure(e.toString()));

    }
  }
  void updateExperience({required int id})
  {
    
    for(int i=0; i<experiences.length;i++)
      {
        try
        {
          if (experiences[i].id == id )
          {
            experiences[i].title = (_nameController?.value)?.toString() ?? experiences[i].title;
            experiences[i].endDate = (_endingYear?.value)?.toString() ?? experiences[i].endDate;
            experiences[i].startDate = (_startingYear?.value)?.toString() ?? experiences[i].startDate;
            experiences[i].organization = (_CompanyController?.value)?.toString() ?? experiences[i].organization;
            emit(TechnicalInfoSuccess());
            break;
          }
        }catch(e)
        {
          emit(TechnicalInfoFailure(e.toString()));
        }
        
      }
  }
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
  void addEduction()
  {

  }
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
