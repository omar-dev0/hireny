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
import '../../features/auth/view/login/cubit/login_vm.dart' as _i866;
import '../../features/auth/view/reg/cubit/reg_vm.dart' as _i981;
import '../../features/course_detailes/presentation/manager/my_courses_cubit.dart'
    as _i743;
import '../../features/org_profile/data/data_sources/org_profile_data_interface.dart'
    as _i30;
import '../../features/org_profile/data/data_sources/org_profile_local_data_source.dart'
    as _i944;
import '../../features/org_profile/data/repo_impl/org_profile_repo_impl.dart'
    as _i91;
import '../../features/org_profile/domain/repositories/org_profile_repo.dart'
    as _i886;
import '../../features/org_profile/domain/usecases/add_review.dart' as _i1064;
import '../../features/org_profile/domain/usecases/get_org_profile.dart'
    as _i431;
import '../../features/org_profile/domain/usecases/get_posts.dart' as _i512;
import '../../features/org_profile/domain/usecases/get_reviews.dart' as _i754;
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
import '../../features/seeker/view/screens/courses/cubit/course_cubit.dart'
    as _i889;
import '../../features/seeker/view/screens/explore_job/cubit/explore_job_cubit.dart'
    as _i401;
import '../../features/seeker/view/screens/job_detailes/cubit/job_detailes_cubit.dart'
    as _i704;
import '../../features/seeker/view/screens/salary_insights/cubit/salary_cubit.dart'
    as _i627;
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
import '../../features/user_accout/cubit/user_cubit.dart' as _i488;
import '../../features/view_application/data/data_sources/app_data_interface.dart'
    as _i867;
import '../../features/view_application/data/data_sources/local_app_data.dart'
    as _i284;
import '../../features/view_application/data/repo_impl/app_repo_impl.dart'
    as _i821;
import '../../features/view_application/domain/repositories/app_repo_interface.dart'
    as _i346;
import '../../features/view_application/domain/usecases/delete_app.dart'
    as _i37;
import '../../features/view_application/domain/usecases/show_app.dart' as _i636;
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
    gh.factory<_i488.UserCubit>(() => _i488.UserCubit());
    gh.factory<_i743.MyCoursesCubit>(() => _i743.MyCoursesCubit());
    gh.factory<_i704.JobDetailesCubit>(() => _i704.JobDetailesCubit());
    gh.lazySingleton<_i361.Dio>(() => dioProvider.dioProvider());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioProvider.providePretty());
    gh.lazySingleton<_i5.AdminDataInterface>(
        () => _i974.AdminLocalDataSource());
    gh.lazySingleton<_i30.OrgProfileDataInterface>(
        () => _i944.OrgProfileLocalDataSource());
    gh.lazySingleton<_i925.OrgDataInterface>(() => _i342.LocalOrgData());
    gh.lazySingleton<_i867.AppDataInterface>(() => _i284.LocalAppData());
    gh.singleton<_i758.ApiManger>(() => _i758.ApiManger(gh<_i361.Dio>()));
    gh.singleton<_i514.SeekerApi>(() => _i514.SeekerApi(gh<_i361.Dio>()));
    gh.factory<_i656.AdminRepoInterface>(
        () => _i587.AdminRepoImpl(gh<_i5.AdminDataInterface>()));
    gh.factory<_i346.AppRepoInterface>(
        () => _i821.AppRepoImpl(gh<_i867.AppDataInterface>()));
    gh.factory<_i946.SeekerDataSource>(
        () => _i886.SeekerDataSourceImpl(gh<_i514.SeekerApi>()));
    gh.factory<_i648.OrgRepo>(
        () => _i564.OrgRepoImpl(gh<_i925.OrgDataInterface>()));
    gh.factory<_i364.AuthDataSource>(
        () => _i591.DataSourcAuthImp(gh<_i758.ApiManger>()));
    gh.factory<_i886.OrgProfileRepo>(
        () => _i91.OrgProfileRepoImpl(gh<_i30.OrgProfileDataInterface>()));
    gh.factory<_i412.RepoAuth>(
        () => _i951.RepoAuthImp(gh<_i364.AuthDataSource>()));
    gh.factory<_i640.DeleteAdmin>(
        () => _i640.DeleteAdmin(adminRepo: gh<_i656.AdminRepoInterface>()));
    gh.factory<_i894.GetAdmins>(
        () => _i894.GetAdmins(adminRepo: gh<_i656.AdminRepoInterface>()));
    gh.factory<_i636.ShowApp>(
        () => _i636.ShowApp(appRepo: gh<_i346.AppRepoInterface>()));
    gh.factory<_i37.DeleteApp>(
        () => _i37.DeleteApp(appRepo: gh<_i346.AppRepoInterface>()));
    gh.factory<_i981.RegSeekerVm>(
        () => _i981.RegSeekerVm(gh<_i412.RepoAuth>()));
    gh.factory<_i598.ShowOrg>(
        () => _i598.ShowOrg(orgRepo: gh<_i648.OrgRepo>()));
    gh.factory<_i81.VerifyOrg>(
        () => _i81.VerifyOrg(orgRepo: gh<_i648.OrgRepo>()));
    gh.factory<_i389.AdminCubit>(() => _i389.AdminCubit(
          gh<_i894.GetAdmins>(),
          gh<_i640.DeleteAdmin>(),
        ));
    gh.factory<_i866.LoginVm>(() => _i866.LoginVm(gh<_i412.RepoAuth>()));
    gh.factory<_i386.SeekerRepository>(
        () => _i475.SeekerRepoImpl(gh<_i946.SeekerDataSource>()));
    gh.factory<_i215.OrgCubit>(() => _i215.OrgCubit(
          gh<_i81.VerifyOrg>(),
          gh<_i598.ShowOrg>(),
        ));
    gh.factory<_i754.GetReviews>(
        () => _i754.GetReviews(profileRepo: gh<_i886.OrgProfileRepo>()));
    gh.factory<_i1064.AddReview>(
        () => _i1064.AddReview(profileRepo: gh<_i886.OrgProfileRepo>()));
    gh.factory<_i431.GetOrgProfile>(
        () => _i431.GetOrgProfile(profileRepo: gh<_i886.OrgProfileRepo>()));
    gh.factory<_i512.GetPosts>(
        () => _i512.GetPosts(profileRepo: gh<_i886.OrgProfileRepo>()));
    gh.factory<_i889.CourseCubit>(
        () => _i889.CourseCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i5.OrgProfileCubit>(() => _i5.OrgProfileCubit(
          gh<_i431.GetOrgProfile>(),
          gh<_i1064.AddReview>(),
          gh<_i754.GetReviews>(),
          gh<_i512.GetPosts>(),
        ));
    gh.factory<_i610.AppCubit>(() => _i610.AppCubit(
          gh<_i37.DeleteApp>(),
          gh<_i636.ShowApp>(),
        ));
    gh.factory<_i627.SalaryCubit>(
        () => _i627.SalaryCubit(gh<_i386.SeekerRepository>()));
    gh.factory<_i401.JobPostCubit>(
        () => _i401.JobPostCubit(gh<_i386.SeekerRepository>()));
    return this;
  }
}

class _$DioProvider extends _i177.DioProvider {}
