part of 'check_in_out_bloc.dart';

abstract class CheckInOutEvent extends Equatable {
  const CheckInOutEvent();

  @override
  List<Object> get props => [];
}

class GetLocation extends CheckInOutEvent {}

class GetImediateLocation extends CheckInOutEvent {
  final Completer<GoogleMapController> controller;
  const GetImediateLocation({
    required this.controller,
  });

  @override
  List<Object> get props => [controller];
}

class CreateOrUpdateCheckInOut extends CheckInOutEvent {}

class CheckCheckInOut extends CheckInOutEvent {
  final CheckMode checkMode;

  const CheckCheckInOut(this.checkMode);

  @override
  List<Object> get props => [checkMode];
}

class ValidateCheckIn extends CheckInOutEvent {}

class CheckInOutReset extends CheckInOutEvent {}
