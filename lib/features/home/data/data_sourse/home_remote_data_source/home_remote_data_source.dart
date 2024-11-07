import 'package:salons_app/features/home/data/model/current_location_request.dart';
import 'package:salons_app/features/home/data/model/current_location_response.dart';

abstract class HomeRemoteDataSource {
  Future<CurrentLocationResponse> getNearestSalons(
      CurrentLocationRequest request);
}
