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
import '../../features/auth/view/user_accout/cubit/user_cubit.dart' as _i906;
import '../../features/profile/presentation/manager/my_courses_cubit.dart'
    as _i267;
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
    gh.factory<_i906.UserCubit>(() => _i906.UserCubit());
    gh.factory<_i267.MyCoursesCubit>(() => _i267.MyCoursesCubit());
    gh.lazySingleton<_i361.Dio>(() => dioProvider.dioProvider());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioProvider.providePretty());
    gh.singleton<_i758.ApiManger>(() => _i758.ApiManger(gh<_i361.Dio>()));
    gh.factory<_i364.AuthDataSource>(
        () => _i591.DataSourcAuthImp(gh<_i758.ApiManger>()));
    gh.factory<_i412.RepoAuth>(
        () => _i951.RepoAuthImp(gh<_i364.AuthDataSource>()));
    gh.factory<_i981.RegSeekerVm>(
        () => _i981.RegSeekerVm(gh<_i412.RepoAuth>()));
    gh.factory<_i866.LoginVm>(() => _i866.LoginVm(gh<_i412.RepoAuth>()));
    return this;
  }
}

class _$DioProvider extends _i177.DioProvider {}
