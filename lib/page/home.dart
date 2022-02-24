import 'package:app_puninar_test/bloc/check_history_bloc.dart';
import 'package:app_puninar_test/bloc/check_in_out_bloc.dart';
import 'package:app_puninar_test/helper/enums.dart';
import 'package:app_puninar_test/route/router_name_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  checkIn(BuildContext context) async {
    var geoPermission = await Permission.locationAlways.request();
    if (geoPermission.isGranted) {
      context
          .read<CheckInOutBloc>()
          .add(const CheckCheckInOut(CheckMode.checkIn));
      context.read<CheckInOutBloc>().add(GetLocation());
    } else if (geoPermission.isDenied) {
      EasyLoading.showInfo("Butuh akses lokasi sebelum check in",
          dismissOnTap: true, duration: const Duration(seconds: 3));
    } else if (geoPermission.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  checkOut(BuildContext context) async {
    var geoPermission = await Permission.locationAlways.request();
    if (geoPermission.isGranted) {
      context
          .read<CheckInOutBloc>()
          .add(const CheckCheckInOut(CheckMode.checkOut));
      context.read<CheckInOutBloc>().add(GetLocation());
    } else if (geoPermission.isDenied) {
      EasyLoading.showInfo("Butuh akses lokasi sebelum check in",
          dismissOnTap: true, duration: const Duration(seconds: 3));
    } else if (geoPermission.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<CheckInOutBloc>().add(ValidateCheckIn());

    return BlocConsumer<CheckInOutBloc, CheckInOutState>(
        listenWhen: (previous, current) =>
            ModalRoute.of(context)!.isCurrent &&
            previous.isLoading != current.isLoading,
        listener: (context, state) async {
          if (state.isLoading) {
            EasyLoading.show(
                status: "Loading...", maskType: EasyLoadingMaskType.clear);
          } else if (!state.isLoading) {
            EasyLoading.dismiss();
            Navigator.pushNamed(context, checkMapsRoute);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      DateFormat("EEEE \n d MMMM yyyy", "id_ID")
                          .format(DateTime.now()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.date_range,
                      size: 59,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Check In / Out Record",
                      style: TextStyle(color: Colors.black, fontSize: 26),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .09,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    checkIn(context);
                                  },
                                  child: const Text("Check In"),
                                ),
                                state.recordedCheckTime.isNotEmpty
                                    ? Text((state.recordedCheckTime[0]
                                            ["datetime"] as String)
                                        .split(" ")[1]
                                        .split(".")[0])
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .09,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: state.isCheckedIn
                                      ? () {
                                          checkOut(context);
                                        }
                                      : null,
                                  child: const Text("Check Out"),
                                ),
                                state.recordedCheckTime.length == 2
                                    ? Text((state.recordedCheckTime[1]
                                            ["datetime"] as String)
                                        .split(" ")[1]
                                        .split(".")[0])
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now()
                                .subtract(const Duration(days: 30)),
                            maxTime: DateTime.now(), onConfirm: (date) {
                          context
                              .read<CheckHistoryBloc>()
                              .add(FindCheckHistory(datetime: date));
                          Navigator.pushNamed(context, checkHistoryResultRoute);
                        }, currentTime: DateTime.now(), locale: LocaleType.id);
                      },
                      icon: const Icon(Icons.history, color: Colors.black),
                      label: const Text(
                        "Check History",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
