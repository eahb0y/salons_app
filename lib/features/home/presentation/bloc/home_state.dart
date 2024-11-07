part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final NearestSalonsResponseEntity? salonsList;
  final double? long;
  final double? lat;

  const HomeState({
    required this.isLoading,
    this.salonsList,
    this.lat,
    this.long,
  });

  factory HomeState.valueInitial() {
    return const HomeState(
      isLoading: false,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    NearestSalonsResponseEntity? salonsList,
    double? long,
    double? lat,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      salonsList: salonsList ?? this.salonsList,
      long: long ?? this.long,
      lat: lat ?? this.lat,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        salonsList,
        long,
        lat,
      ];
}
