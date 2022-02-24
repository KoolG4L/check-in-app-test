import 'dart:async';

import 'package:app_puninar_test/bloc/check_in_out_bloc.dart';
import 'package:app_puninar_test/helper/enums.dart';
import 'package:app_puninar_test/route/router_name_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckMaps extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  CheckMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckInOutBloc, CheckInOutState>(
      listener: (context, state) {
        if (state.savingState == SavingState.loading) {
          EasyLoading.show(
            status: "Loading...",
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: false,
          );
        } else if (state.savingState == SavingState.success) {
          Navigator.pushReplacementNamed(context, checkInOutResultRoute);
          EasyLoading.dismiss();
        } else if (state.savingState == SavingState.failed) {
          EasyLoading.dismiss();
          EasyLoading.showError("Error upload check in");
        }
      },
      builder: (context, state) {
        var latLng = LatLng(state.location.latitude, state.location.longitude);

        final _currentPosition = CameraPosition(target: latLng, zoom: 20);

        final _currentMarker = Marker(
            markerId: const MarkerId("_currentMarker"),
            icon: BitmapDescriptor.defaultMarker,
            position: latLng);

        final _currentCircle = Circle(
            circleId: const CircleId("_currentCircle"),
            fillColor: Colors.lightBlue.withOpacity(0.2),
            strokeColor: Colors.transparent,
            center: latLng,
            radius: 25);

        return WillPopScope(
          onWillPop: () async {
            return state.savingState != SavingState.loading;
          },
          child: Scaffold(
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                GoogleMap(
                  markers: {_currentMarker},
                  circles: {_currentCircle},
                  zoomControlsEnabled: false,
                  rotateGesturesEnabled:
                      state.savingState == SavingState.loading ? false : true,
                  zoomGesturesEnabled:
                      state.savingState == SavingState.loading ? false : true,
                  mapType: MapType.normal,
                  initialCameraPosition: _currentPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: FloatingActionButton(
                            child: Icon(
                              Icons.gps_fixed,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              _getCurrentPosition(context);
                            },
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .165,
                          color: Colors.white,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ))),
                              onPressed: () async {
                                context
                                    .read<CheckInOutBloc>()
                                    .add(CreateOrUpdateCheckInOut());
                              },
                              child: const Text("Check-In")),
                        ),
                      ],
                    )),
                Positioned(
                  top: 52.0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
                    child: const Text(
                      "Konfirmasi Lokasi",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, .25),
                            blurRadius: 16.0)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _getCurrentPosition(BuildContext context) {
    context
        .read<CheckInOutBloc>()
        .add(GetImediateLocation(controller: _controller));
  }
}
