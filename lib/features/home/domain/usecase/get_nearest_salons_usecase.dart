import 'package:dartz/dartz.dart';
import 'package:salons_app/core/error/failure.dart';
import 'package:salons_app/core/usecase/usecase.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salon_request_entity.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salons_response_entity.dart';
import 'package:salons_app/features/home/domain/repository/home_repository.dart';

class GetNearestSalonsUseCase
    extends UseCase<NearestSalonsResponseEntity, NearestSalonRequestEntity> {
  final HomeRepository repository;

  GetNearestSalonsUseCase(this.repository);

  @override
  Future<Either<Failure, NearestSalonsResponseEntity>> call(
      NearestSalonRequestEntity params) async {
    final result = await repository.getNearestSalon(params);
    return result;
  }
}
