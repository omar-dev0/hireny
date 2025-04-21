// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/api/api_manger.dart' as _i758;
import '../../features/auth/data/data_source/auth_data_source.dart' as _i364;
import '../../features/auth/data/data_source_imp/auth_data_source_imp.dart'
    as _i591;
import '../../features/auth/data/repo_imp/repo_auth_imp.dart' as _i951;
import '../../features/auth/domain/repo_contract/repo_contract.dart' as _i412;
import '../../features/auth/view/login/cubit/login_vm.dart' as _i866;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i758.ApiManger>(() => _i758.ApiManger());
    gh.factory<_i364.AuthDataSource>(
      () => _i591.DataSourcAuthImp(gh<_i758.ApiManger>()),
    );
    gh.factory<_i412.RepoAuth>(
      () => _i951.RepoAuthImp(gh<_i364.AuthDataSource>()),
    );
    gh.factory<_i866.LoginVm>(() => _i866.LoginVm(gh<_i412.RepoAuth>()));
    return this;
  }
}
