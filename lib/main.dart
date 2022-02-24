import 'package:app_puninar_test/bloc/check_history_bloc.dart';
import 'package:app_puninar_test/bloc/check_in_out_bloc.dart';
import 'package:app_puninar_test/repository/repository.dart';
import 'package:app_puninar_test/route/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("id_ID", null);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final url = "http://192.168.137.1:8080/api";
  //TODO: ganti link nya jadi ipv4

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CheckInOutRepository>(
          create: (context) => CheckInOutRepository(url: url),
        ),
        RepositoryProvider<CheckHistoryRepository>(
          create: (context) => CheckHistoryRepository(url: url),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CheckInOutBloc>(
            create: (context) => CheckInOutBloc(
                checkInRepository:
                    RepositoryProvider.of<CheckInOutRepository>(context)),
          ),
          BlocProvider<CheckHistoryBloc>(
            create: (context) => CheckHistoryBloc(
                checkHistoryRepository:
                    RepositoryProvider.of<CheckHistoryRepository>(context)),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test Puninar App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
