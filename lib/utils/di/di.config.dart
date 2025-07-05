// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../features/auth/data/api/api_manger.dart' as _i758;
import '../../features/auth/data/data_source/auth_data_source.dart' as _i364;
import '../../features/auth/data/data_source_imp/auth_data_source_imp.dart'
    as _i591;
import '../../features/auth/data/repo_imp/repo_auth_imp.dart' as _i951;
import '../../features/auth/domain/repo_contract/repo_contract.dart' as _i412;
import '../../features/auth/view/forget_password/cubit/forget_password_vm.dart'
    as _i413;
import '../../features/auth/view/login/cubit/login_vm.dart' as _i866;
import '../../features/auth/view/profile/ai_tools/cubit/ai_cubit.dart' as _i71;
import '../../features/auth/view/profile/cubit/user_cubit.dart' as _i609;
import '../../features/auth/view/reg/cubit/reg_vm.dart' as _i981;
import '../../features/calender/data/api/api_manger.dart' as _i2;
import '../../features/calender/data/data_contratc/calender_data_source.dart'
    as _i523;
import '../../features/calender/data/data_source/calender_data_source_imp.dart'
    as _i342;
import '../../features/calender/data/repo_imp/calender_repo_imp.dart' as _i223;
import '../../features/calender/domain/repo_contract/calender_repo_contract.dart'
    as _i225;
import '../../features/calender/ui/cubit/calender_cubit.dart' as _i164;
import '../../features/chat_bot/data/api/api_chatboot_manger.dart' as _i174;
import '../../features/chat_bot/data/data_source/chat_bot_data_source.dart'
    as _i1018;
import '../../features/chat_bot/data/data_source_imp/chat_bot_data_source_imp.dart'
    as _i347;
import '../../features/chat_bot/data/repo_imp/chat_bot_repo_imp.dart' as _i731;
import '../../features/chat_bot/domain/repo_contract/chat_bot_repo_contract.dart'
    as _i48;
import '../../features/chat_bot/UI/cubit/chat_bot_cubit.dart' as _i471;
import '../../features/my_assessment/presentation/cubit/user_assessment_cubit.dart'
    as _i201;
import '../../features/my_assessment/presentation/ui/assissment_detailes/cubit/assiss_cubit.dart'
    as _i721;
import '../../features/notification/data/api/api_manger.dart' as _i572;
import '../../features/notification/data/data_source/notification_data_source.dart'
    as _i707;
import '../../features/notification/data/data_source_imp/notification_data_source_imp.dart'
    as _i541;
import '../../features/notification/data/repo_imp/notification_repo_imp.dart'
    as _i742;
import '../../features/notification/domain/repo_contract/notification_repo.dart'
    as _i823;
import '../../features/notification/ui/cubit/notification_cubit.dart' as _i504;
import '../../features/org_profile/data/api/api_manger.dart' as _i527;
import '../../features/org_profile/data/data_source/org_profile_data_source.dart'
    as _i297;
import '../../features/org_profile/data/data_source_imp/org_profile_data_source_imp.dart'
    as _i749;
import '../../features/org_profile/data/repo_imp/org_profile_repo_imp.dart'
    as _i568;
import '../../features/org_profile/domain/repo_contract/org_profile_repo_contratc.dart'
    as _i814;
import '../../features/org_profile/presentation/manager/org_profile_cubit.dart'
    as _i5;
import '../../features/seeker/data/api/seeker_api.dart' as _i514;
import '../../features/seeker/data/data_source/seeker_data_source.dart'
    as _i946;
import '../../features/seeker/data/data_source_imp/seeker_data_source_impl.dart'
    as _i886;
import '../../features/seeker/data/repo_imp/seeker_repo_impl.dart' as _i475;
import '../../features/seeker/domain/repo_contract/seeker_repository.dart'
    as _i386;
import '../../features/seeker/view/screens/course_details/cubit/course_details_cubit.dart'
    as _i938;
import '../../features/seeker/view/screens/courses/cubit/course_cubit.dart'
    as _i889;
import '../../features/seeker/view/screens/explore_job/cubit/explore_job_cubit.dart'
    as _i401;
import '../../features/seeker/view/screens/explore_org_seeker/cubit/explore_org_for_seeker_cubit.dart'
    as _i123;
import '../../features/seeker/view/screens/job_detailes/application_deatailes/cubit/application_deatailes_cubit.dart'
    as _i507;
import '../../features/seeker/view/screens/job_detailes/cubit/job_detailes_cubit.dart'
    as _i704;
import '../../features/seeker/view/screens/salary_insights/cubit/salary_cubit.dart'
    as _i627;
import '../../features/services/data/data_source/service_org_data_source.dart'
    as _i618;
import '../../features/services/data/data_source/service_org_data_source_interface.dart'
    as _i387;
import '../../features/services/data/repo_impl/service_org_repo_impl.dart'
    as _i472;
import '../../features/services/data/service_api/service_api_manager.dart'
    as _i341;
import '../../features/services/domain/repo/service_org_repo_interface.dart'
    as _i154;
import '../../features/services/domain/usecases/add_service_org_post.dart'
    as _i607;
import '../../features/services/presentation/manager/service_org_cubit.dart'
    as _i896;
import '../../features/show_admin/data/data_sources/admin_data_interface.dart'
    as _i5;
import '../../features/show_admin/data/data_sources/admin_local_data_source.dart'
    as _i974;
import '../../features/show_admin/data/repo_impl/admin_repo_impl.dart' as _i587;
import '../../features/show_admin/domain/repositories/admin_repo_interface.dart'
    as _i656;
import '../../features/show_admin/domain/usecases/delete_admin.dart' as _i640;
import '../../features/show_admin/domain/usecases/get_admins.dart' as _i894;
import '../../features/show_admin/presentation/manager/admin_cubit.dart'
    as _i389;
import '../../features/show_courses/data/api/course_api_manager.dart' as _i451;
import '../../features/show_courses/data/data_sources/course_data_interface.dart'
    as _i234;
import '../../features/show_courses/data/data_sources/local_course_data.dart'
    as _i338;
import '../../features/show_courses/data/repo_impl/course_repo_impl.dart'
    as _i248;
import '../../features/show_courses/domain/repositories/CourseRepo.dart'
    as _i630;
import '../../features/show_courses/domain/usecases/show_courses.dart' as _i714;
import '../../features/show_courses/presentation/ui/manager/seeker_course_cubit.dart'
    as _i583;
import '../../features/view_application/data/api/api_manger.dart' as _i417;
import '../../features/view_application/data/data_source/application_data_scource.dart'
    as _i674;
import '../../features/view_application/data/data_source_imp/application_data_source_imp.dart'
    as _i337;
import '../../features/view_application/data/repo_imp/application_repo_imp.dart'
    as _i1009;
import '../../features/view_application/domain/repo_contract/application_repo_contratc.dart'
    as _i901;
import '../../features/view_application/presentation/manager/app_cubit.dart'
    as _i610;
import '../../features/view_org_for_seeker/data/data_sources/local_org_data.dart'
    as _i342;
import '../../features/view_org_for_seeker/data/data_sources/org_data_interface.dart'
    as _i925;
import '../../features/view_org_for_seeker/data/repo_impl/org_repo_impl.dart'
    as _i564;
import '../../features/view_org_for_seeker/domain/repositories/org_repo.dart'
    as _i648;
import '../../features/view_org_for_seeker/domain/usecases/show_org.dart'
    as _i598;
import '../../features/view_org_for_seeker/domain/usecases/verify_org.dart'
    as _i81;
import '../../features/view_org_for_seeker/presentation/manager/org_cubit.dart'
    as _i215;
import '../../technical_info/data/api/api_manager.dart' as _i409;
import '../../technical_info/data/data_source/tech_data_source.dart' as _i411;
import '../../technical_info/data/data_source/tech_remote_data_source.dart'
    as _i136;
import '../../technical_info/data/repo_impl/repo_impl.dart' as _i557;
import '../../technical_info/domain/repo/tech_repo.dart' as _i854;
import '../../technical_info/domain/usecases/delete_tech_info.dart' as _i377;
import '../../technical_info/domain/usecases/get_tech_info.dart' as _i394;
import '../../technical_info/domain/usecases/tech_usecase.dart' as _i883;
import '../../technical_info/domain/usecases/update_tech_info.dart' as _i120;
import '../../technical_info/presentation/manager/technical_info_cubit.dart'
    as _i953;
import '../dio_provider.dart' as _i177;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioProvider = _$DioProvider();
    gh.factory<_i71.AiCubit>(() => _i71.AiCubit());
    gh.lazySingleton<_i361.Dio>(() => dioProvider.dioProvider());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioProvider.providePretty());
    gh.lazySingleton<_i5.AdminDataInterface>(
        () => _i974.AdminLocalDataSource());
    gh.lazySingleton<_i925.OrgDataInterface>(() => _i342.LocalOrgData());
    gh.singleton<_i572.NotificationApiManger>(
        () => _i572.NotificationApiManger(gh<_i361.Dio>()));
    gh.singleton<_i527.OrgProfileApi>(
        () => _i527.OrgProfileApi(gh<_i361.Dio>()));
    gh.singleton<_i451.CoursesApiManager>(
        () => _i451.CoursesApiManager(gh<_i361.Dio>()));
    gh.singleton<_i758.ApiManger>(() => _i758.ApiManger(gh<_i361.Dio>()));
    gh.singleton<_i2.CalenderApi>(() => _i2.CalenderApi(gh<_i361.Dio>()));
    gh.singleton<_i174.ChatBootApiManger>(
        () => _i174.ChatBootApiManger(gh<_i361.Dio>()));
    gh.singleton<_i514.SeekerApi>(() => _i514.SeekerApi(gh<_i361.Dio>()));
    gh.singleton<_i341.ServiceApiManager>(
        () => _i341.ServiceApiManager(gh<_i361.Dio>()));
    gh.singleton<_i409.TechApiManager>(
        () => _i409.TechApiManager(gh<_i361.Dio>()));
    gh.singleton<_i417.ApplicationApi>(
        () => _i417.ApplicationApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i387.ServiceOrgDataSourceInterface>(
        () => _i618.ServiceOrgDataSource(gh<_i341.ServiceApiManager>()));
    gh.factory<_i656.AdminRepoInterface>(
        () => _i587.AdminRepoImpl(gh<_i5.AdminDataInterface>()));
    gh.factory<_i523.CalenderDataSource>(
        () => _i342.CalenderDataSourceImp(gh<_i2.CalenderApi>()));
    gh.lazySingleton<_i154.ServiceOrgRepoInterface>(() =>
        _i472.ServiceOrgRepoImpl(gh<_i387.ServiceOrgDataSourceInterface>()));
    gh.factory<_i946.SeekerDataSource>(
        () => _i886.SeekerDataSourceImpl(gh<_i514.SeekerApi>()));
    gh.factory<_i648.OrgRepo>(
        () => _i564.OrgRepoImpl(gh<_i925.OrgDataInterface>()));
    gh.lazySingleton<_i411.TechDataSourceInterface>(
        () => _i136.TechDataSource(gh<_i409.TechApiManager>()));
    gh.factory<_i364.AuthDataSource>(
        () => _i591.DataSourcAuthImp(gh<_i758.ApiManger>()));
    gh.factory<_i225.CalenderRepoContract>(
        () => _i223.CalenderRepoImp(gh<_i523.CalenderDataSource>()));
    gh.factory<_i707.NotificationDataSource>(() =>
        _i541.NotificationDataSourceImp(gh<_i572.NotificationApiManger>()));
    gh.factory<_i412.RepoAuth>(
        () => _i951.RepoAuthImp(gh<_i364.AuthDataSource>()));
    gh.factory<_i413.ForgetPasswordVM>(
        () => _i413.ForgetPasswordVM(gh<_i412.RepoAuth>()));
    gh.factory<_i164.CalenderCubit>(
        () => _i164.CalenderCubit(gh<_i225.CalenderRepoContract>()));
    gh.factory<_i640.DeleteAdmin>(
        () => _i640.DeleteAdmin(adminRepo: gh<_i656.AdminRepoInterface>()));
    gh.factory<_i894.GetAdmins>(
        () => _i894.GetAdmins(adminRepo: gh<_i656.AdminRepoInterface>()));
    gh.lazySingleton<_i234.CourseDataInterface>(
        () => _i338.LocalCourseData(gh<_i451.CoursesApiManager>()));
    gh.factory<_i1018.ChatBootDataSource>(
        () => _i347.ChatBootDataSourceImp(gh<_i174.ChatBootApiManger>()));
    gh.factory<_i674.ApplicationDataSource>(
        () => _i337.ApplicationDataSourceImp(gh<_i417.ApplicationApi>()));
    gh.factory<_i297.OrgProfileDataSource>(
        () => _i749.OrgProfileDataSourceImp(gh<_i527.OrgProfileApi>()));
    gh.factory<_i823.NotificationRepo>(
        () => _i742.NotificationRepoImp(gh<_i707.NotificationDataSource>()));
    gh.factory<_i901.ApplicationRepo>(
        () => _i1009.ApplicationRepoImp(gh<_i674.ApplicationDataSource>()));
    gh.factory<_i607.AddServiceOrgPost>(
        () => _i607.AddServiceOrgPost(gh<_i154.ServiceOrgRepoInterface>()));
    gh.factory<_i896.ServiceOrgCubit>(
        () => _i896.ServiceOrgCubit(gh<_i607.AddServiceOrgPost>()));
    gh.factory<_i981.RegSeekerVm>(
        () => _i981.RegSeekerVm(gh<_i412.RepoAuth>()));
    gh.factory<_i721.AssissmentCubit>(
        () => _i721.AssissmentCubit(gh<_i412.RepoAuth>()));
    gh.factory<_i504.NotificationCubit>(
        () => _i504.NotificationCubit(gh<_i823.NotificationRepo>()));
    gh.factory<_i598.ShowOrg>(
        () => _i598.ShowOrg(orgRepo: gh<_i648.OrgRepo>()));
    gh.factory<_i81.VerifyOrg>(
        () => _i81.VerifyOrg(orgRepo: gh<_i648.OrgRepo>()));
    gh.factory<_i389.AdminCubit>(() => _i389.AdminCubit(
          gh<_i894.GetAdmins>(),
          gh<_i640.DeleteAdmin>(),
        ));
    gh.factory<_i609.UserCubit>(() => _i609.UserCubit(gh<_i412.RepoAuth>()));
    gh.factory<_i866.LoginVm>(() => _i866.LoginVm(gh<_i412.RepoAuth>()));
    gh.factory<_i201.UserAssessmentCubit>(
        () => _i201.UserAssessmentCubit(gh<_i412.RepoAuth>()));
    gh.factory<_i386.SeekerRepository>(
        () => _i475.SeekerRepoImpl(gh<_i946.SeekerDataSource>()));
    gh.factory<_i814.OrgProfileRepoContract>(
        () => _i568.OrgProfileRepoImp(gh<_i297.OrgProfileDataSource>()));
    gh.factory<_i630.CourseRepo>(
        () => _i248.CourseRepoImpl(gh<_i234.CourseDataInterface>()));
    gh.factory<_i215.OrgCubit>(() => _i215.OrgCubit(
          gh<_i81.VerifyOrg>(),
          gh<_i598.ShowOrg>(),
        ));
    gh.lazySingleton<_i854.TechRepoInterface>(
        () => _i557.TechRepoImpl(gh<_i411.TechDataSourceInterface>()));
    gh.factory<_i889.CourseCubit>(
        () => _i889.CourseCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i48.ChatBootRepo>(
        () => _i731.ChatBootRepoImp(gh<_i1018.ChatBootDataSource>()));
    gh.factory<_i938.CourseDetailsCubit>(
        () => _i938.CourseDetailsCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i704.JobDetailsCubit>(
        () => _i704.JobDetailsCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i627.SalaryCubit>(
        () => _i627.SalaryCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i123.OrgPostCubit>(
        () => _i123.OrgPostCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i507.ApplicationDeatailesCubit>(
        () => _i507.ApplicationDeatailesCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i610.AppCubit>(
        () => _i610.AppCubit(gh<_i901.ApplicationRepo>()));
    gh.factory<_i714.ShowCourses>(
        () => _i714.ShowCourses(courseRepo: gh<_i630.CourseRepo>()));
    gh.factory<_i401.JobPostCubit>(
        () => _i401.JobPostCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i471.ChatBotCubit>(
        () => _i471.ChatBotCubit(gh<_i48.ChatBootRepo>()));
    gh.factory<_i5.OrgProfileCubit>(
        () => _i5.OrgProfileCubit(gh<_i814.OrgProfileRepoContract>()));
    gh.factory<_i120.UpdateTechInfo>(
        () => _i120.UpdateTechInfo(gh<_i854.TechRepoInterface>()));
    gh.factory<_i377.DeleteTechInfo>(
        () => _i377.DeleteTechInfo(gh<_i854.TechRepoInterface>()));
    gh.factory<_i883.AddTechInfo>(
        () => _i883.AddTechInfo(gh<_i854.TechRepoInterface>()));
    gh.factory<_i394.GetTechInfo>(
        () => _i394.GetTechInfo(gh<_i854.TechRepoInterface>()));
    gh.factory<_i583.SeekerCoursesCubit>(
        () => _i583.SeekerCoursesCubit(gh<_i714.ShowCourses>()));
    gh.factory<_i953.TechnicalInfoCubit>(() => _i953.TechnicalInfoCubit(
          gh<_i883.AddTechInfo>(),
          gh<_i394.GetTechInfo>(),
          gh<_i377.DeleteTechInfo>(),
          gh<_i120.UpdateTechInfo>(),
        ));
    return this;
  }
}

class _$DioProvider extends _i177.DioProvider {}
