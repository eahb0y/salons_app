import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salon_request_entity.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salons_response_entity.dart';
import 'package:salons_app/features/home/domain/usecase/get_nearest_salons_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNearestSalonsUseCase getNearestSalonsUseCase;

  HomeBloc(this.getNearestSalonsUseCase) : super(HomeState.valueInitial()) {
    on<HomeInitialCallEvent>(_initialCall);
  }

  Future<void> _initialCall(
      HomeInitialCallEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getNearestSalonsUseCase(NearestSalonRequestEntity(
      long: '',
      lat: '',
    ));

    result.fold((l) {
      emit(state.copyWith(isLoading: false));

    }, (r) {
      emit(state.copyWith(
        isLoading: false,
        salonsList: r,
      ));
    });
  }

  Future<bool> _getCurrentLocationPermission() async {
    Location location = Location();
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    if (permissionGranted == PermissionStatus.granted) {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }
      return serviceEnabled;
    }
    return false;
  }
}
