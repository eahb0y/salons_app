import 'package:dio/dio.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:salons_app/features/home/data/data_sourse/home_remote_data_source/home_remote_data_source.dart';
import 'package:salons_app/features/home/data/data_sourse/home_remote_data_source/home_remote_data_source_impl.dart';
import 'package:salons_app/features/home/data/repository/home_repository_impl.dart';
import 'package:salons_app/features/home/domain/repository/home_repository.dart';
import 'package:salons_app/features/home/domain/usecase/get_nearest_salons_usecase.dart';
import 'package:salons_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:salons_app/router/app_routes.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () => Dio()
      ..interceptors.addAll([
        LogInterceptor(
          request: kDebugMode,
          responseBody: kDebugMode,
          error: kDebugMode,
          requestBody: kDebugMode,
        ),
        chuck.getDioInterceptor(),
      ])
      ..options.contentType = 'application/json'
      ..options.sendTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.connectTimeout = const Duration(seconds: 10),
  );
  sl<Dio>().interceptors.add(
        RetryInterceptor(
          dio: sl<Dio>(),
          retryDelays: const [Duration(seconds: 3), Duration(seconds: 2)],
          toNoInternetPageNavigator: () async {},
          forbiddenFunction: () async {},
          logPrint: (message) {
            if (kDebugMode) {
              print(message);
            }
          },
        ),
      );

  // Features
  _homeFeature();
}

void _homeFeature() {
  /// Bloc
  sl.registerFactory(() => HomeBloc(sl()));

  /// UseCases
  sl.registerLazySingleton<GetNearestSalonsUseCase>(
      () => GetNearestSalonsUseCase(sl()));

  ///Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      sl(),
    ),
  );

  /// Data and Network
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      sl(),
    ),
  );
}
