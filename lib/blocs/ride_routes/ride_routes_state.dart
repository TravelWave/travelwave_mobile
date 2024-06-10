import 'package:travelwave_mobile/models/driver_info.dart';
import 'package:travelwave_mobile/models/ride_info_model.dart';
import 'package:travelwave_mobile/models/user_info.dart';

abstract class RideRouteState {}

class RideRoutesStateInitial extends RideRouteState {}

class RideRoutesStateLoading extends RideRouteState {}

class RideRoutesStateSuccess extends RideRouteState {
  final DriverInfo userInfo;
  final RideInfo rideInfo;

  RideRoutesStateSuccess({
    required this.userInfo,
    required this.rideInfo,
  });
}

class RideRoutesStateFailure extends RideRouteState {
  final String error;
  RideRoutesStateFailure({required this.error});
}
