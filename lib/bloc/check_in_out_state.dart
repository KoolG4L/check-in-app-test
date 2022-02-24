part of 'check_in_out_bloc.dart';

class CheckInOutState extends Equatable {
  final Location location;
  final DateTime currentTime;
  final bool isLoading;
  final SavingState savingState;
  final String imagePath;
  final bool isCheckedIn;
  final List checkedInOutData;
  final CheckMode checkMode;
  final List recordedCheckTime;
  final bool validateLoading;
  CheckInOutState(
      {this.location = const Location(latitude: 0, longitude: 0),
      DateTime? currentTime,
      this.isLoading = false,
      this.savingState = SavingState.initial,
      this.imagePath = "",
      this.isCheckedIn = false,
      this.checkedInOutData = const [],
      this.checkMode = CheckMode.checkIn,
      this.recordedCheckTime = const [],
      this.validateLoading = true})
      : currentTime = currentTime ?? DateTime.now();

  @override
  List<Object> get props => [
        location,
        currentTime,
        savingState,
        isLoading,
        imagePath,
        isCheckedIn,
        checkedInOutData,
        checkMode,
        recordedCheckTime,
        validateLoading
      ];

  CheckInOutState copyWith(
      {Location? location,
      DateTime? currentTime,
      bool? isLoading,
      SavingState? savingState,
      String? imagePath,
      bool? isCheckedIn,
      List? checkedInOutData,
      CheckMode? checkMode,
      List? recordedCheckTime,
      bool? validateLoading}) {
    return CheckInOutState(
        currentTime: currentTime ?? this.currentTime,
        location: location ?? this.location,
        isLoading: isLoading ?? this.isLoading,
        savingState: savingState ?? this.savingState,
        imagePath: imagePath ?? this.imagePath,
        isCheckedIn: isCheckedIn ?? this.isCheckedIn,
        checkedInOutData: checkedInOutData ?? this.checkedInOutData,
        checkMode: checkMode ?? this.checkMode,
        recordedCheckTime: recordedCheckTime ?? this.recordedCheckTime,
        validateLoading: validateLoading ?? this.validateLoading);
  }

  CheckInOutState reset() => CheckInOutState();
}
