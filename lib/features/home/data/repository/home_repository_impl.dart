import 'package:dartz/dartz.dart';
import 'package:salons_app/core/error/failure.dart';
import 'package:salons_app/features/home/data/data_sourse/home_remote_data_source/home_remote_data_source.dart';
import 'package:salons_app/features/home/data/model/current_location_request.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salon_request_entity.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salons_response_entity.dart';
import 'package:salons_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, NearestSalonsResponseEntity>> getNearestSalon(
      NearestSalonRequestEntity request) async {
    // try {
      final response = await remoteDataSource.getNearestSalons(
        CurrentLocationRequest(
          address5Blatitude5D: request.lat,
          address5Blongitude5D: request.long,
        ),
      );
      return Right(response.toEntity());
    // } catch (e) {
    //   return Left(
    //     ServerFailure(
    //       message: e.toString(),
    //     ),
    //   );
    // }
  }
}
