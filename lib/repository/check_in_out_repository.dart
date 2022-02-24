import 'dart:convert';
import 'dart:io';

import 'package:app_puninar_test/helper/enums.dart';
import 'package:app_puninar_test/model/model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import 'package:app_puninar_test/bloc/check_in_out_bloc.dart';

class CheckInOutRepository {
  final String url;
  CheckInOutRepository({
    required this.url,
  });

  var headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  UploadTask? uploadPhoto(String dest, File file) {
    try {
      Reference storageRef = FirebaseStorage.instance.ref().child(dest);
      UploadTask task = storageRef.putFile(file);
      return task;
    } on FirebaseException catch (_) {
      return null;
    }
  }

  UploadTask? reUploadPhoto(String dest, File file, String prevImageUrl) {
    try {
      FirebaseStorage.instance.refFromURL(prevImageUrl).delete();
      Reference storageRef = FirebaseStorage.instance.ref().child(dest);
      UploadTask task = storageRef.putFile(file);
      return task;
    } on FirebaseException catch (_) {
      return null;
    }
  }

  Future<ResultModel> validateCheckIn() async {
    var response =
        await http.get(Uri.parse(url + '/validateCheckIn'), headers: headers);
    var data = json.decode(response.body);
    return ResultModel.fromMap(data);
  }

  Future<ResultModel> checkCheckInOut(CheckMode checkMode) async {
    final String mode = checkMode == CheckMode.checkIn ? "checkIn" : "checkOut";

    var response =
        await http.get(Uri.parse(url + '/$mode/check'), headers: headers);
    var data = json.decode(response.body);
    return ResultModel.fromMap(data);
  }

  Future<ResultModel> createCheckInOut(
      String imageURL, CheckInOutState state) async {
    final String mode =
        state.checkMode == CheckMode.checkIn ? "checkIn" : "checkOut";
    var response = await http.post(Uri.parse(url + '/$mode/create'),
        headers: headers,
        body: json.encode({
          "latitude": state.location.latitude,
          "longitude": state.location.longitude,
          "datetime": state.currentTime.toString(),
          "imageUrl": imageURL
        }));
    var data = json.decode(response.body);
    return ResultModel.fromMap(data);
  }

  Future<ResultModel> updateCheckInOut(
      String imageURL, CheckInOutState state, int id) async {
    final String mode =
        state.checkMode == CheckMode.checkIn ? "checkIn" : "checkOut";
    var response = await http.put(Uri.parse(url + '/$mode/update/$id'),
        headers: headers,
        body: json.encode({
          "latitude": state.location.latitude,
          "longitude": state.location.longitude,
          "datetime": state.currentTime.toString(),
          "imageUrl": imageURL
        }));
    var data = json.decode(response.body);
    return ResultModel.fromMap(data);
  }
}
