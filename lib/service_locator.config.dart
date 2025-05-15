// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:to_do_project/data/network/dio.dart' as _i504;
import 'package:to_do_project/data/network/rest_client.dart' as _i102;
import 'package:to_do_project/data/repositories/app_notifications_reposirtory.dart'
    as _i890;
import 'package:to_do_project/data/repositories/auth_repository.dart' as _i613;
import 'package:to_do_project/data/repositories/quotes_repository.dart' as _i88;
import 'package:to_do_project/data/repositories/tasks_repository.dart' as _i260;
import 'package:to_do_project/presentation/auth/bloc/auth_bloc.dart' as _i903;
import 'package:to_do_project/presentation/quote/bloc/quote_bloc.dart' as _i983;
import 'package:to_do_project/presentation/tasks/bloc/tasks_cubit.dart' as _i370;
import 'package:to_do_project/utlis/shared_preference.dart' as _i226;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dioModule = _$DioModule();
  gh.factory<_i226.SharedPreferenceHelper>(
      () => _i226.SharedPreferenceHelper());
  gh.lazySingleton<_i361.Dio>(() => dioModule.getDio());
  gh.lazySingleton<_i613.AuthRepository>(() => _i613.AuthRepositoryImpl());
  gh.lazySingleton<_i504.DioService>(() => _i504.DioService(gh<_i361.Dio>()));
  gh.factory<_i102.RestClient>(() => _i102.RestClient(gh<_i361.Dio>()));
  gh.lazySingleton<_i903.AuthCubit>(
      () => _i903.AuthCubit(gh<_i613.AuthRepository>()));
  gh.lazySingleton<_i88.QuotesRepository>(
      () => _i88.QuotesRepositoryImpl(apiClient: gh<_i102.RestClient>()));
  gh.lazySingleton<_i260.TasksRepository>(
      () => _i260.TasksRepositoryImpl(apiClient: gh<_i102.RestClient>()));
  gh.lazySingleton<_i890.AppNotificationsRepository>(() =>
      _i890.AppNotificationsRepositoryImpl(apiClient: gh<_i102.RestClient>()));
  gh.lazySingleton<_i370.TasksCubit>(
      () => _i370.TasksCubit(gh<_i260.TasksRepository>()));
  gh.lazySingleton<_i983.QuoteCubit>(
      () => _i983.QuoteCubit(gh<_i88.QuotesRepository>()));
  return getIt;
}

class _$DioModule extends _i504.DioModule {}
