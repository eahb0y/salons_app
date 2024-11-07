import 'package:dio/dio.dart';
import 'package:salons_app/constants/constants.dart';
import 'package:salons_app/features/home/data/data_sourse/home_remote_data_source/home_remote_data_source.dart';
import 'package:salons_app/features/home/data/model/current_location_request.dart';
import 'package:salons_app/features/home/data/model/current_location_response.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<CurrentLocationResponse> getNearestSalons(
      CurrentLocationRequest request) async {
    try {
      final response = await dio.get(BaseUrls.baseUrl, queryParameters: {
        AppConst.lang: "en",
        AppConst.locationType: 2,
        AppConst.lat: request.address5Blatitude5D,
        AppConst.long: request.address5Blongitude5D,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CurrentLocationResponse.fromJson(response.data);
      }
      throw CurrentLocationResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.toString();
    } on FormatException {
      throw Validations.someThingWentWrong;
    }
  }
}
