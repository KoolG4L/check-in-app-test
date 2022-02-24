import 'package:app_puninar_test/bloc/check_history_bloc.dart';
import 'package:app_puninar_test/page/check_maps_history.dart';
import 'package:app_puninar_test/route/router_name_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckHistoryResult extends StatelessWidget {
  const CheckHistoryResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<CheckHistoryBloc, CheckHistoryState>(
        builder: (context, state) {
          if (state is CheckHistoryLoaded) {
            if (state.historyData.isEmpty) {
              return const Center(
                  child: Text("Check history belum dimasukkan"));
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Check In Detail",
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: state.historyData[0].imageurl,
                              width: 175,
                              height: 175,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(width: 25),
                            Column(
                              children: [
                                const Text(
                                  "Waktu :",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                    state.historyData[0].datetime
                                        .split(" ")[1]
                                        .split(".")[0],
                                    style: const TextStyle(fontSize: 15)),
                                const SizedBox(height: 10),
                                MaterialButton(
                                    color: Colors.black,
                                    child: const Text(
                                      "Lihat di map",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: (() {
                                      Navigator.pushNamed(
                                          context, checkHistoryMapsRoute,
                                          arguments: CheckMapsHistory(
                                              isCheckIn: true,
                                              longitude: state
                                                  .historyData[0].longitude,
                                              latitude: state
                                                  .historyData[0].latitude));
                                    }))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text("Latitude : ${state.historyData[0].latitude}"),
                        Text("Longitude : ${state.historyData[0].longitude}")
                      ],
                    ),
                  ),
                  Expanded(
                    child: state.historyData.length == 2
                        ? Column(
                            children: [
                              const Text(
                                "Check Out Detail",
                                style: TextStyle(fontSize: 22),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: state.historyData[1].imageurl,
                                    width: 175,
                                    height: 175,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  const SizedBox(width: 25),
                                  Column(
                                    children: [
                                      const Text(
                                        "Waktu :",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                          state.historyData[1].datetime
                                              .split(" ")[1]
                                              .split(".")[0],
                                          style: const TextStyle(fontSize: 15)),
                                      const SizedBox(height: 10),
                                      MaterialButton(
                                          color: Colors.black,
                                          child: const Text(
                                            "Lihat di map",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: (() {
                                            Navigator.pushNamed(
                                                context, checkHistoryMapsRoute,
                                                arguments: CheckMapsHistory(
                                                    isCheckIn: false,
                                                    longitude: state
                                                        .historyData[1]
                                                        .longitude,
                                                    latitude: state
                                                        .historyData[1]
                                                        .latitude));
                                          }))
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  "Latitude : ${state.historyData[1].latitude}"),
                              Text(
                                  "Longitude : ${state.historyData[1].longitude}")
                            ],
                          )
                        : const Center(
                            child: Text("Data check out belum masuk")),
                  ),
                ],
              ),
            );
          } else if (state is CheckHistoryFailed) {
            return Center(child: Text(state.errMessage));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
