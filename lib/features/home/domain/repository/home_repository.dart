import 'package:dartz/dartz.dart';
import 'package:salons_app/core/error/failure.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salon_request_entity.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salons_response_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, NearestSalonsResponseEntity>> getNearestSalon(
      NearestSalonRequestEntity request);
}
