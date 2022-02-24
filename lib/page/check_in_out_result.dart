import 'dart:io';

import 'package:app_puninar_test/bloc/check_in_out_bloc.dart';
import 'package:app_puninar_test/helper/enums.dart';
import 'package:app_puninar_test/route/router_name_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheckInOutResult extends StatelessWidget {
  const CheckInOutResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInOutBloc, CheckInOutState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.read<CheckInOutBloc>().add(CheckInOutReset());
            context.read<CheckInOutBloc>().add(ValidateCheckIn());
            return true;
          },
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.imagePath != ""
                      ? ClipOval(
                          child: Image.file(
                            File(state.imagePath),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Text("Error :S"),
                  const SizedBox(height: 10),
                  Text(
                    "Waktu Check-${state.checkMode == CheckMode.checkIn ? "In" : "Out"} :",
                    textAlign: TextAlign.center,
                  ),
                  Text(DateFormat("EEEE d MMMM yyyy | hh:mm:ss", "id_ID")
                      .format(state.currentTime)),
                  const SizedBox(height: 35),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        homeRoute,
                        (route) => false,
                      );
                      context.read<CheckInOutBloc>().add(CheckInOutReset());
                      context.read<CheckInOutBloc>().add(ValidateCheckIn());
                    },
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: const Text(
                      "Kembali",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
