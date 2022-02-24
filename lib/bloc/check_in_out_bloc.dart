import 'dart:async';
import 'dart:io';

import 'package:app_puninar_test/helper/enums.dart';
import 'package:app_puninar_test/model/location_model.dart';
import 'package:app_puninar_test/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

part 'check_in_out_event.dart';
part 'check_in_out_state.dart';

class CheckInOutBloc extends Bloc<CheckInOutEvent, CheckInOutState> {
  final CheckInOutRepository checkInRepository;

  CheckInOutBloc({required this.checkInRepository}) : super(CheckInOutState()) {
    on<GetLocation>(_getLocation);
    on<GetImediateLocation>(_getImediateLocation);
    on<CreateOrUpdateCheckInOut>(_createOrUpdateCheckInOut);
    on<CheckCheckInOut>(_checkCheckInOut);
    on<ValidateCheckIn>(_validateCheckIn);
    on<CheckInOutReset>(_checkInOutReset);
  }

  void _getLocation(GetLocation event, Emitter<CheckInOutState> emit) async {
    emit(state.copyWith(isLoading: true));
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var latitude = position.latitude;
    var longitude = position.longitude;
    var location = Location(longitude: longitude, latitude: latitude);

    emit(state.copyWith(isLoading: false, location: location));
  }

  void _getImediateLocation(
      GetImediateLocation event, Emitter<CheckInOutState> emit) async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var latitude = position.latitude;
    var longitude = position.longitude;
    var location = Location(longitude: longitude, latitude: latitude);
    var _currentPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 20);

    final GoogleMapController controller = await event.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPosition));

    emit(state.copyWith(isLoading: false, location: location));
  }

  void _createOrUpdateCheckInOut(
      CreateOrUpdateCheckInOut event, Emitter<CheckInOutState> emit) async {
    try {
      var currentTime = DateTime.now();

      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (image != null) {
        emit(state.copyWith(
            savingState: SavingState.loading,
            currentTime: currentTime,
            imagePath: image.path));

        if (state.checkedInOutData.isEmpty) {
          File file = File(state.imagePath);
          var fileName = basename(file.path);
          final dest = "files/images/$fileName";
          var taskSnapshot = await checkInRepository.uploadPhoto(dest, file);

          if (taskSnapshot != null) {
            final imageUrl = await taskSnapshot.ref.getDownloadURL();

            await checkInRepository.createCheckInOut(imageUrl, state);

            emit(state.copyWith(
              savingState: SavingState.success,
            ));
          }
        } else {
          File file = File(state.imagePath);
          var fileName = basename(file.path);
          final dest = "files/images/$fileName";
          var taskSnapshot = await checkInRepository.reUploadPhoto(
              dest, file, state.checkedInOutData[0]["imageurl"]);

          if (taskSnapshot != null) {
            final imageUrl = await taskSnapshot.ref.getDownloadURL();

            await checkInRepository.updateCheckInOut(
                imageUrl, state, state.checkedInOutData[0]["id"]);

            emit(state.copyWith(
              savingState: SavingState.success,
            ));
          }
        }
      }
    } catch (e) {
      emit(state.copyWith(imagePath: ""));
    }
  }

  void _checkCheckInOut(
      CheckCheckInOut event, Emitter<CheckInOutState> emit) async {
    try {
      state.copyWith(
          savingState: SavingState.loading, checkMode: event.checkMode);
      var result = await checkInRepository.checkCheckInOut(event.checkMode);

      if (result.data!.isNotEmpty) {
        emit(state.copyWith(checkedInOutData: result.data));
      }
      emit(state.copyWith(checkMode: event.checkMode));
    } catch (e) {
      emit(state.copyWith(savingState: SavingState.failed));
      rethrow;
    }
  }

  void _validateCheckIn(
      ValidateCheckIn event, Emitter<CheckInOutState> emit) async {
    try {
      var result = await checkInRepository.validateCheckIn();
      if (result.valid) {
        emit(state.copyWith(
            isCheckedIn: true,
            recordedCheckTime: result.data,
            validateLoading: false));
      } else {
        emit(state.copyWith(isCheckedIn: false, validateLoading: false));
      }
    } catch (e) {
      rethrow;
    }
  }

  void _checkInOutReset(CheckInOutReset event, Emitter<CheckInOutState> emit) {
    emit(state.reset());
  }
}
