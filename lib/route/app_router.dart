import 'package:app_puninar_test/page/check_history_result.dart';
import 'package:app_puninar_test/page/check_maps.dart';
import 'package:app_puninar_test/page/check_maps_history.dart';
import 'package:app_puninar_test/page/home.dart';
import 'package:app_puninar_test/page/check_in_out_result.dart';
import 'package:app_puninar_test/route/router_name_const.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );
      case checkMapsRoute:
        return MaterialPageRoute(
          builder: (context) => CheckMaps(),
        );
      case checkInOutResultRoute:
        return MaterialPageRoute(
          builder: (context) => const CheckInOutResult(),
        );
      case checkHistoryResultRoute:
        return MaterialPageRoute(
          builder: (context) => const CheckHistoryResult(),
        );
      case checkHistoryMapsRoute:
        var args = settings.arguments as CheckMapsHistory;
        return MaterialPageRoute(
          builder: (context) => CheckMapsHistory(
            isCheckIn: args.isCheckIn,
            latitude: args.latitude,
            longitude: args.longitude,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
